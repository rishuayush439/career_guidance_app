
// import 'dart:io';
// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:dash_chat_2/dash_chat_2.dart';
// import 'package:flutter_gemini/flutter_gemini.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:flutter_tts/flutter_tts.dart';

// class ChatbotPage extends StatefulWidget {
//   const ChatbotPage({super.key});

//   @override
//   State<ChatbotPage> createState() => _ChatbotPageState();
// }

// class _ChatbotPageState extends State<ChatbotPage> {
//   final Gemini gemini = Gemini.instance;
//   final stt.SpeechToText _speechToText = stt.SpeechToText();
//   final FlutterTts flutterTts = FlutterTts();

//   List<ChatMessage> messages = [];
//   bool isTyping = false;
//   bool isListening = false;
//   bool isSpeaking = false; 
//   bool readAllowed = false; 

//   final ChatUser currentUser = ChatUser(id: "0", firstName: "User");
//   final ChatUser geminiUser = ChatUser(
//     id: "1",
//     firstName: "Gemini",
//     profileImage:
//         "https://seeklogo.com/images/G/google-gemini-logo-A5787B2669-seeklogo.com.png",
//   );

//   @override
//   void initState() {
//     super.initState();
//     _loadMessagesFromStorage();
//     _initializeSpeechRecognizer();
//     _initializeTTS(); // Initialize TTS
//   }

//   void _initializeTTS() async {
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.setPitch(1.0);

 
//     flutterTts.setStartHandler(() {
//       setState(() {
//         isSpeaking = true;
//       });
//     });

//     flutterTts.setCompletionHandler(() {
//       setState(() {
//         isSpeaking = false;
//       });
//     });

//     flutterTts.setErrorHandler((msg) {
//       setState(() {
//         isSpeaking = false;
//       });
//     });
//   }

  
//   Future<void> _speak(String text) async {
//     if (!readAllowed || text.trim().isEmpty) return;

//     List<String> lines = text.split('\n'); 
//     for (String line in lines) {
//       if (line.trim().isNotEmpty) {
//         await flutterTts.speak(line.trim());
       
//         while (isSpeaking) {
//           await Future.delayed(const Duration(milliseconds: 20));
//         }
//         await Future.delayed(
//             const Duration(milliseconds: 60));
//       }
//     }
//   }

//   Future<void> _loadMessagesFromStorage() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String? messagesJson = prefs.getString('chat_messages');
//     if (messagesJson != null) {
//       final List<dynamic> decodedMessages = jsonDecode(messagesJson);
//       setState(() {
//         messages = decodedMessages
//             .map((message) => ChatMessage.fromJson(message))
//             .toList();
//       });
//     } else {
//       _sendBotGreeting();
//     }
//   }

//   Future<void> _saveMessagesToStorage() async {
//     final prefs = await SharedPreferences.getInstance();
//     final String messagesJson =
//         jsonEncode(messages.map((message) => message.toJson()).toList());
//     await prefs.setString('chat_messages', messagesJson);
//   }

//   void _sendBotGreeting() {
//     Future.delayed(const Duration(milliseconds: 800), () {
//       setState(() {
//         messages.insert(
//           0,
//           ChatMessage(
//             user: geminiUser,
//             createdAt: DateTime.now(),
//             text:
//                 '👋 Hey there! I\'m here to assist you with career guidance and more.\n\nAsk me anything!',
//           ),
//         );
//         _saveMessagesToStorage();
//         _speak(
//             'Hey there! I\'m here to assist you with career guidance and more. Ask me anything!');
//       });
//     });
//   }

//   void _sendMessage(ChatMessage chatMessage) {
//     setState(() {
//       messages.insert(0, chatMessage);
//       isTyping = true;
//       _addTypingIndicator();
//       _saveMessagesToStorage();
//     });

//     try {
//       final String question = chatMessage.text;
//       List<Uint8List>? images;

//       if (chatMessage.medias?.isNotEmpty ?? false) {
//         images = [
//           File(chatMessage.medias!.first.url).readAsBytesSync(),
//         ];
//       }

//       gemini.streamGenerateContent(question, images: images).listen((event) {
//         String response = event.content?.parts?.fold(
//               "",
//               (previous, part) {
//                 if (part is TextPart) {
//                   return "$previous ${part.text}";
//                 }
//                 return previous;
//               },
//             ) ??
//             "🤔 I\'m here to help! Could you rephrase or ask something else?";

//         response = response.trim().replaceAll('\n\n', '\n');

//         final ChatMessage botMessage = ChatMessage(
//           user: geminiUser,
//           createdAt: DateTime.now(),
//           text: response,
//         );

//         setState(() {
//           _removeTypingIndicator();
//           messages.insert(0, botMessage);
//           isTyping = false;
//           _saveMessagesToStorage();
//         });

//         _speak(response); 
//       });
//     } catch (e) {
//       debugPrint("Error: $e");
//       setState(() {
//         isTyping = false;
//         _removeTypingIndicator();
//         messages.insert(
//           0,
//           ChatMessage(
//             user: geminiUser,
//             createdAt: DateTime.now(),
//             text: "⚠️ Something went wrong. Please try again.",
//           ),
//         );
//         _saveMessagesToStorage();
//       });
//     }
//   }

//   void _addTypingIndicator() {
//     final ChatMessage typingMessage = ChatMessage(
//       user: geminiUser,
//       createdAt: DateTime.now(),
//       text: "typing-indicator",
//     );

//     setState(() {
//       messages.insert(0, typingMessage);
//     });
//   }

//   void _removeTypingIndicator() {
//     if (messages.isNotEmpty &&
//         messages.first.user == geminiUser &&
//         messages.first.text == "typing-indicator") {
//       setState(() {
//         messages.removeAt(0);
//       });
//     }
//   }

//   void _sendMediaMessage() async {
//     final ImagePicker picker = ImagePicker();
//     final XFile? file = await picker.pickImage(
//       source: ImageSource.gallery,
//     );
//     if (file != null) {
//       final ChatMessage chatMessage = ChatMessage(
//         user: currentUser,
//         createdAt: DateTime.now(),
//         text: "Describe this picture?",
//         medias: [
//           ChatMedia(
//             url: file.path,
//             fileName: "",
//             type: MediaType.image,
//           ),
//         ],
//       );
//       _sendMessage(chatMessage);
//     }
//   }

//   Future<void> _initializeSpeechRecognizer() async {
//     bool available = await _speechToText.initialize();
//     if (!available) {
//       print("Speech recognition is not available");
//     }
//   }

//   void _startListening() async {
//     if (!_speechToText.isListening) {
//       setState(() {
//         isListening = true;
//       });
//       _speechToText.listen(onResult: (result) {
//         final speechText = result.recognizedWords;
//         if (speechText.isNotEmpty) {
//           final ChatMessage chatMessage = ChatMessage(
//             user: currentUser,
//             createdAt: DateTime.now(),
//             text: speechText,
//           );
//           _sendMessage(chatMessage);
//         }
//       });
//     }
//   }

//   void _stopListening() {
//     _speechToText.stop();
//     setState(() {
//       isListening = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("🎓 Career Bot"),
//         backgroundColor: const Color.fromARGB(255, 107, 107, 210),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () async {
//               final prefs = await SharedPreferences.getInstance();
//               await prefs.remove('chat_messages');
//               setState(() {
//                 messages.clear();
//               });
//               _sendBotGreeting();
//             },
//           ),
//           IconButton(
//             icon: Icon(
//               readAllowed ? Icons.volume_up : Icons.volume_off,
//               color: readAllowed ? Colors.green : Colors.red,
//             ),
//             onPressed: () {
//               setState(() {
//                 readAllowed = !readAllowed;
//               });
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Stack(
//               children: [
//                 DashChat(
//                   inputOptions: InputOptions(
//                     trailing: [
//                       IconButton(
//                         onPressed: _sendMediaMessage,
//                         icon: const Icon(Icons.image),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           isListening ? Icons.stop : Icons.mic,
//                           color: isListening ? Colors.red : Colors.blue,
//                         ),
//                         onPressed:
//                             isListening ? _stopListening : _startListening,
//                       ),
//                     ],
//                   ),
//                   currentUser: currentUser,
//                   onSend: _sendMessage,
//                   messages: messages,
//                   messageOptions: const MessageOptions(showTime: true),
//                 ),
//                 if (isTyping)
//                   Positioned(
//                     bottom: 10,
//                     right: 10,
//                     child: Container(
//                       padding: const EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.7),
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: const Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text("Thinking...",
//                               style: TextStyle(color: Colors.white)),
//                           SizedBox(width: 8),
//                           CircularProgressIndicator(
//                             color: Colors.white,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final Gemini gemini = Gemini.instance;
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  final FlutterTts flutterTts = FlutterTts();
  final GlobalKey _chatKey = GlobalKey();

  List<ChatMessage> messages = [];
  bool isTyping = false;
  bool isListening = false;
  bool isSpeaking = false;
  bool readAllowed = false;

  final ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  final ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "Gemini",
    profileImage:
        "https://seeklogo.com/images/G/google-gemini-logo-A5787B2669-seeklogo.com.png",
  );

  @override
  void initState() {
    super.initState();
    _loadMessagesFromStorage();
    _initializeSpeechRecognizer();
    _initializeTTS();
  }

  void _initializeTTS() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.8);

    flutterTts.setStartHandler(() {
      setState(() {
        isSpeaking = true;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  Future<void> _speak(String text) async {
    if (!readAllowed || text.trim().isEmpty) return;

    try {
      String cleanText = text
          .replaceAll('*', '')
          .replaceAll('#', '')
          .replaceAll('```', '')
          .replaceAll(RegExp(r'\n+'), '. ')
          .trim();

      if (cleanText.isNotEmpty) {
        await flutterTts.speak(cleanText);
      }
    } catch (e) {
      debugPrint("TTS Error: $e");
    }
  }

  Future<void> _loadMessagesFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? messagesJson = prefs.getString('chat_messages');
      if (messagesJson != null) {
        final List<dynamic> decodedMessages = jsonDecode(messagesJson);
        setState(() {
          messages = decodedMessages
              .map((message) => ChatMessage.fromJson(message))
              .toList();
        });
        _scrollToBottom();
      } else {
        _sendBotGreeting();
      }
    } catch (e) {
      debugPrint("Error loading messages: $e");
      _sendBotGreeting();
    }
  }

  Future<void> _saveMessagesToStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String messagesJson =
          jsonEncode(messages.map((message) => message.toJson()).toList());
      await prefs.setString('chat_messages', messagesJson);
    } catch (e) {
      debugPrint("Error saving messages: $e");
    }
  }

  void _sendBotGreeting() {
    Future.delayed(const Duration(milliseconds: 500), () {
      final greetingMessage = ChatMessage(
        user: geminiUser,
        createdAt: DateTime.now(),
        text:
            '👋 Hello! I\'m your Career Guidance Assistant. I can help you with:\n\n'
            '• Career advice and guidance\n'
            '• Skill development tips\n'
            '• Interview preparation\n'
            '• Resume building\n'
            '• And much more!\n\n'
            'What would you like to know today?',
      );

      setState(() {
        messages.insert(0, greetingMessage);
        _saveMessagesToStorage();
      });
      _scrollToBottom();
      _speak(
          "Hello! I'm your Career Guidance Assistant. How can I help you today?");
    });
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages.insert(0, chatMessage);
      isTyping = true;
      _saveMessagesToStorage();
    });
    _scrollToBottom();

    try {
      final String question = chatMessage.text;
      List<Uint8List>? images;

      if (chatMessage.medias?.isNotEmpty ?? false) {
        try {
          images = [File(chatMessage.medias!.first.url).readAsBytesSync()];
        } catch (e) {
          debugPrint("Error reading image: $e");
        }
      }

      String accumulatedResponse = "";
      bool isFirstChunk = true;

      gemini.streamGenerateContent(question, images: images).listen(
        (event) {
          String chunk = event.content?.parts?.fold(
                "",
                (previous, part) {
                  if (part is TextPart) {
                    return "$previous${part.text}";
                  }
                  return previous;
                },
              ) ??
              "";

          accumulatedResponse += chunk;

          if (isFirstChunk) {
            isFirstChunk = false;
            final ChatMessage botMessage = ChatMessage(
              user: geminiUser,
              createdAt: DateTime.now(),
              text: _formatResponse(accumulatedResponse),
            );
            setState(() {
              messages.insert(0, botMessage);
              _saveMessagesToStorage();
            });
          } else {
            setState(() {
              messages.first = ChatMessage(
                user: geminiUser,
                createdAt: DateTime.now(),
                text: _formatResponse(accumulatedResponse),
              );
            });
          }
          _scrollToBottom();
        },
        onError: (error) {
          debugPrint("Gemini Error: $error");
          _handleError();
        },
        onDone: () {
          setState(() {
            isTyping = false;
            _saveMessagesToStorage();
          });
          _speak(accumulatedResponse);
        },
        cancelOnError: false,
      );
    } catch (e) {
      debugPrint("Error sending message: $e");
      _handleError();
    }
  }

  String _formatResponse(String response) {
    return response
        .trim()
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .replaceAll(RegExp(r' {2,}'), ' ')
        .replaceAll('•', '•')
        .trim();
  }

  void _handleError() {
    setState(() {
      isTyping = false;
      messages.insert(
        0,
        ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text:
              "⚠️ I'm having trouble connecting right now. Please check your internet connection and try again.",
        ),
      );
      _saveMessagesToStorage();
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    // DashChat handles scrolling automatically, but we can ensure
    // the messages are properly displayed by rebuilding
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
  }

  void _sendMediaMessage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? file = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (file != null) {
        final ChatMessage chatMessage = ChatMessage(
          user: currentUser,
          createdAt: DateTime.now(),
          text:
              "Can you analyze this image and provide career-related insights?",
          medias: [
            ChatMedia(
              url: file.path,
              fileName: "image.jpg",
              type: MediaType.image,
            ),
          ],
        );
        _sendMessage(chatMessage);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to pick image. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _initializeSpeechRecognizer() async {
    try {
      bool available = await _speechToText.initialize();
      if (!available) {
        debugPrint("Speech recognition is not available");
      }
    } catch (e) {
      debugPrint("Speech recognition init error: $e");
    }
  }

  void _startListening() async {
    if (!_speechToText.isListening) {
      bool available = await _speechToText.initialize();
      if (!available) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Speech recognition not available"),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      setState(() {
        isListening = true;
      });

      _speechToText.listen(
        onResult: (result) {
          if (result.finalResult) {
            final speechText = result.recognizedWords.trim();
            if (speechText.isNotEmpty) {
              final ChatMessage chatMessage = ChatMessage(
                user: currentUser,
                createdAt: DateTime.now(),
                text: speechText,
              );
              _sendMessage(chatMessage);
            }
            _stopListening();
          }
        },
        listenFor: const Duration(seconds: 30),
        cancelOnError: true,
        partialResults: true,
      );
    }
  }

  void _stopListening() {
    _speechToText.stop();
    setState(() {
      isListening = false;
    });
  }

  void _clearChat() async {
    final shouldClear = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Clear Chat"),
        content: const Text("Are you sure you want to clear all messages?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              "Clear",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (shouldClear == true) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('chat_messages');
      setState(() {
        messages.clear();
      });
      _sendBotGreeting();
    }
  }

  void _stopSpeaking() {
    flutterTts.stop();
    setState(() {
      isSpeaking = false;
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    _speechToText.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🎓 Career Guide"),
        backgroundColor: const Color.fromARGB(255, 107, 107, 210),
        actions: [
          if (isSpeaking)
            IconButton(
              icon: const Icon(Icons.stop, color: Colors.red),
              onPressed: _stopSpeaking,
              tooltip: "Stop Speaking",
            ),
          IconButton(
            icon: Icon(
              readAllowed ? Icons.volume_up : Icons.volume_off,
              color: readAllowed ? Colors.green : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                readAllowed = !readAllowed;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    readAllowed
                        ? "Text-to-Speech enabled"
                        : "Text-to-Speech disabled",
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            tooltip: readAllowed ? "Disable Voice" : "Enable Voice",
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _clearChat,
            tooltip: "Clear Chat",
          ),
        ],
      ),
      body: Column(
        children: [
          if (isListening)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.blue.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.mic, color: Colors.blue[700]),
                  const SizedBox(width: 8),
                  Text(
                    "Listening...",
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          if (isSpeaking)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.green.withOpacity(0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.volume_up, color: Colors.green[700]),
                  const SizedBox(width: 8),
                  Text(
                    "Speaking...",
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Stack(
              children: [
                DashChat(
                  key: _chatKey,
                  inputOptions: InputOptions(
                    // Remove the textController parameter as it's not needed
                    trailing: [
                      IconButton(
                        onPressed: _sendMediaMessage,
                        icon: const Icon(Icons.image),
                        tooltip: "Send Image",
                      ),
                      IconButton(
                        icon: Icon(
                          isListening ? Icons.stop : Icons.mic,
                          color: isListening ? Colors.red : Colors.blue,
                        ),
                        onPressed:
                            isListening ? _stopListening : _startListening,
                        tooltip: isListening
                            ? "Stop Listening"
                            : "Start Voice Input",
                      ),
                    ],
                    inputTextStyle: const TextStyle(fontSize: 16),
                    sendButtonBuilder: (send) => IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: send,
                      color: const Color.fromARGB(255, 107, 107, 210),
                    ),
                  ),
                  currentUser: currentUser,
                  onSend: _sendMessage,
                  messages: messages,
                  messageOptions: MessageOptions(
                    showTime: true,
                    timeFontSize: 12,
                    textColor: Colors.black,
                    currentUserTextColor: Colors.white,
                    containerColor: Colors.grey,
                    currentUserContainerColor:
                        const Color.fromARGB(255, 107, 107, 210),
                  ),
                ),
                if (isTyping)
                  Positioned(
                    bottom: 80,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(left: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Career Guide is typing",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 8),
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
