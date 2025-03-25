
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
    _initializeTTS(); // Initialize TTS
  }

  void _initializeTTS() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);

 
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

    List<String> lines = text.split('\n'); 
    for (String line in lines) {
      if (line.trim().isNotEmpty) {
        await flutterTts.speak(line.trim());
       
        while (isSpeaking) {
          await Future.delayed(const Duration(milliseconds: 20));
        }
        await Future.delayed(
            const Duration(milliseconds: 60));
      }
    }
  }

  Future<void> _loadMessagesFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String? messagesJson = prefs.getString('chat_messages');
    if (messagesJson != null) {
      final List<dynamic> decodedMessages = jsonDecode(messagesJson);
      setState(() {
        messages = decodedMessages
            .map((message) => ChatMessage.fromJson(message))
            .toList();
      });
    } else {
      _sendBotGreeting();
    }
  }

  Future<void> _saveMessagesToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String messagesJson =
        jsonEncode(messages.map((message) => message.toJson()).toList());
    await prefs.setString('chat_messages', messagesJson);
  }

  void _sendBotGreeting() {
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        messages.insert(
          0,
          ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text:
                '👋 Hey there! I\'m here to assist you with career guidance and more.\n\nAsk me anything!',
          ),
        );
        _saveMessagesToStorage();
        _speak(
            'Hey there! I\'m here to assist you with career guidance and more. Ask me anything!');
      });
    });
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages.insert(0, chatMessage);
      isTyping = true;
      _addTypingIndicator();
      _saveMessagesToStorage();
    });

    try {
      final String question = chatMessage.text;
      List<Uint8List>? images;

      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }

      gemini.streamGenerateContent(question, images: images).listen((event) {
        String response = event.content?.parts?.fold(
              "",
              (previous, part) {
                if (part is TextPart) {
                  return "$previous ${part.text}";
                }
                return previous;
              },
            ) ??
            "🤔 I\'m here to help! Could you rephrase or ask something else?";

        response = response.trim().replaceAll('\n\n', '\n');

        final ChatMessage botMessage = ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: response,
        );

        setState(() {
          _removeTypingIndicator();
          messages.insert(0, botMessage);
          isTyping = false;
          _saveMessagesToStorage();
        });

        _speak(response); 
      });
    } catch (e) {
      debugPrint("Error: $e");
      setState(() {
        isTyping = false;
        _removeTypingIndicator();
        messages.insert(
          0,
          ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: "⚠️ Something went wrong. Please try again.",
          ),
        );
        _saveMessagesToStorage();
      });
    }
  }

  void _addTypingIndicator() {
    final ChatMessage typingMessage = ChatMessage(
      user: geminiUser,
      createdAt: DateTime.now(),
      text: "typing-indicator",
    );

    setState(() {
      messages.insert(0, typingMessage);
    });
  }

  void _removeTypingIndicator() {
    if (messages.isNotEmpty &&
        messages.first.user == geminiUser &&
        messages.first.text == "typing-indicator") {
      setState(() {
        messages.removeAt(0);
      });
    }
  }

  void _sendMediaMessage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      final ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "Describe this picture?",
        medias: [
          ChatMedia(
            url: file.path,
            fileName: "",
            type: MediaType.image,
          ),
        ],
      );
      _sendMessage(chatMessage);
    }
  }

  Future<void> _initializeSpeechRecognizer() async {
    bool available = await _speechToText.initialize();
    if (!available) {
      print("Speech recognition is not available");
    }
  }

  void _startListening() async {
    if (!_speechToText.isListening) {
      setState(() {
        isListening = true;
      });
      _speechToText.listen(onResult: (result) {
        final speechText = result.recognizedWords;
        if (speechText.isNotEmpty) {
          final ChatMessage chatMessage = ChatMessage(
            user: currentUser,
            createdAt: DateTime.now(),
            text: speechText,
          );
          _sendMessage(chatMessage);
        }
      });
    }
  }

  void _stopListening() {
    _speechToText.stop();
    setState(() {
      isListening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🎓 Career Bot"),
        backgroundColor: const Color.fromARGB(255, 107, 107, 210),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('chat_messages');
              setState(() {
                messages.clear();
              });
              _sendBotGreeting();
            },
          ),
          IconButton(
            icon: Icon(
              readAllowed ? Icons.volume_up : Icons.volume_off,
              color: readAllowed ? Colors.green : Colors.red,
            ),
            onPressed: () {
              setState(() {
                readAllowed = !readAllowed;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                DashChat(
                  inputOptions: InputOptions(
                    trailing: [
                      IconButton(
                        onPressed: _sendMediaMessage,
                        icon: const Icon(Icons.image),
                      ),
                      IconButton(
                        icon: Icon(
                          isListening ? Icons.stop : Icons.mic,
                          color: isListening ? Colors.red : Colors.blue,
                        ),
                        onPressed:
                            isListening ? _stopListening : _startListening,
                      ),
                    ],
                  ),
                  currentUser: currentUser,
                  onSend: _sendMessage,
                  messages: messages,
                  messageOptions: const MessageOptions(showTime: true),
                ),
                if (isTyping)
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Thinking...",
                              style: TextStyle(color: Colors.white)),
                          SizedBox(width: 8),
                          CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ],
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

