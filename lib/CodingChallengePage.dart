
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

// class CodingChallengePage extends StatefulWidget {
//   const CodingChallengePage({Key? key}) : super(key: key);

//   @override
//   _CodingChallengePageState createState() => _CodingChallengePageState();
// }

// class _CodingChallengePageState extends State<CodingChallengePage> {
//   List<Map<String, dynamic>> challenges = [];
//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();
//   final TextEditingController detailsController = TextEditingController();
//   final TextEditingController solutionController = TextEditingController();
//   final TextEditingController explanationController = TextEditingController();
//   String difficulty = 'Easy';

//   @override
//   void initState() {
//     super.initState();
//     _loadChallenges();
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     descriptionController.dispose();
//     detailsController.dispose();
//     solutionController.dispose();
//     explanationController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadChallenges() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String? challengesJson = prefs.getString('challenges');
//       if (challengesJson != null) {
//         setState(() {
//           challenges =
//               List<Map<String, dynamic>>.from(jsonDecode(challengesJson));
//         });
//       }
//     } catch (e) {
//       debugPrint("Error loading challenges: $e");
//     }
//   }

//   Future<void> _saveChallenges() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       String jsonString = jsonEncode(challenges);
//       await prefs.setString('challenges', jsonString);
//     } catch (e) {
//       debugPrint("Error saving challenges: $e");
//     }
//   }

//   void _addChallenge() {
//     if (titleController.text.isNotEmpty &&
//         descriptionController.text.isNotEmpty &&
//         detailsController.text.isNotEmpty &&
//         solutionController.text.isNotEmpty &&
//         explanationController.text.isNotEmpty) {
//       setState(() {
//         challenges.add({
//           'title': titleController.text,
//           'description': descriptionController.text,
//           'challengeDetails': detailsController.text,
//           'solution': solutionController.text,
//           'explanation': explanationController.text,
//           'difficulty': difficulty,
//           'starPoints': 0, // Initialize with 0 star points
//         });
//       });
//       _saveChallenges();
//       Navigator.pop(context);
//     }
//   }

//   void _deleteChallenge(int index) {
//     setState(() {
//       challenges.removeAt(index);
//     });
//     _saveChallenges();
//   }

//   void _showAddChallengeDialog() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text('Add a New Challenge'),
//           content: SingleChildScrollView(
//             child: Column(
//               children: [
//                 _buildTextField('Title', titleController),
//                 _buildTextField('Description', descriptionController),
//                 _buildTextField('Challenge Details', detailsController),
//                 _buildTextField('Solution', solutionController),
//                 _buildTextField('Explanation', explanationController),
//                 DropdownButtonFormField<String>(
//                   decoration: const InputDecoration(labelText: 'Difficulty'),
//                   value: difficulty,
//                   items: ['Easy', 'Medium', 'Hard']
//                       .map((level) => DropdownMenuItem(
//                             value: level,
//                             child: Text(level),
//                           ))
//                       .toList(),
//                   onChanged: (value) => setState(() {
//                     difficulty = value!;
//                   }),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             ElevatedButton(
//               onPressed: _addChallenge,
//               child: const Text('Add'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller) {
//     return TextField(
//       controller: controller,
//       decoration: InputDecoration(labelText: label),
//       maxLines: null, 
//     );
//   }

//   void _showCodeEditor(int index, String solution) {
//     bool isSolutionVisible = false;
//     final TextEditingController userCodeController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return AlertDialog(
//               title: const Text('Code Editor'),
//               content: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text('Your Code:',
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     TextField(
//                       controller: userCodeController,
//                       maxLines: 10,
//                       decoration: const InputDecoration(
//                         hintText: 'Write your code here...',
//                         border: OutlineInputBorder(),
//                       ),
//                       keyboardType: TextInputType.multiline,
//                       textInputAction: TextInputAction.newline,
//                     ),
//                     const SizedBox(height: 16),
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           isSolutionVisible = !isSolutionVisible;
//                         });
//                       },
//                       child: Text(isSolutionVisible
//                           ? 'Hide Solution'
//                           : 'View Solution'),
//                     ),
//                     if (isSolutionVisible) ...[
//                       const SizedBox(height: 16),
//                       const Text('Solution:',
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       TextField(
//                         controller: TextEditingController(text: solution),
//                         maxLines: 10,
//                         decoration: const InputDecoration(
//                           hintText: 'View solution here...',
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.multiline,
//                         textInputAction: TextInputAction.newline,
//                         readOnly: true, // Make it read-only
//                       ),
//                     ]
//                   ],
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Close'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Check if the user's code matches the solution
//                     if (userCodeController.text.trim() == solution.trim()) {
//                       setState(() {
//                         challenges[index]['starPoints'] += 1; // Add star point
//                       });
//                     }
//                     debugPrint("Code Submitted: ${userCodeController.text}");
//                     Navigator.pop(context);
//                   },
//                   child: const Text('Submit'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Daily Coding Challenges'),
//         backgroundColor: const Color.fromARGB(255, 107, 107, 210),
//       ),
//       body: challenges.isEmpty
//           ? const Center(child: Text('No challenges added yet.'))
//           : ListView.builder(
//               padding: const EdgeInsets.all(16.0),
//               itemCount: challenges.length,
//               itemBuilder: (context, index) {
//                 final challenge = challenges[index];
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: ChallengeCard(
//                     challenge: challenge,
//                     onDelete: () => _deleteChallenge(index),
//                     onCodeTap: () =>
//                         _showCodeEditor(index, challenge['solution']),
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _showAddChallengeDialog,
//         backgroundColor: const Color.fromARGB(255, 107, 107, 210),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class ChallengeCard extends StatelessWidget {
//   final Map<String, dynamic> challenge;
//   final VoidCallback onDelete;
//   final VoidCallback onCodeTap;

//   const ChallengeCard({
//     Key? key,
//     required this.challenge,
//     required this.onDelete,
//     required this.onCodeTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     challenge['title']!,
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.delete, color: Colors.red),
//                   onPressed: onDelete,
//                 ),
//               ],
//             ),
//             Text(challenge['description']!),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 const Icon(Icons.star, color: Colors.yellow, size: 20),
//                 const SizedBox(width: 5),
//                 Text('${challenge['starPoints']} Star Points'),
//               ],
//             ),
//             const SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: onCodeTap,
//               child: const Text('Start Coding'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CodingChallengePage extends StatefulWidget {
  const CodingChallengePage({Key? key}) : super(key: key);

  @override
  _CodingChallengePageState createState() => _CodingChallengePageState();
}

class _CodingChallengePageState extends State<CodingChallengePage> {
  List<Map<String, dynamic>> challenges = [];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController solutionController = TextEditingController();
  final TextEditingController explanationController = TextEditingController();
  String difficulty = 'Easy';
  int _totalStars = 0;

  @override
  void initState() {
    super.initState();
    _loadChallenges();
    _calculateTotalStars();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    detailsController.dispose();
    solutionController.dispose();
    explanationController.dispose();
    super.dispose();
  }

  Future<void> _loadChallenges() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? challengesJson = prefs.getString('challenges');
      if (challengesJson != null) {
        setState(() {
          challenges =
              List<Map<String, dynamic>>.from(jsonDecode(challengesJson));
        });
        _calculateTotalStars();
      }
    } catch (e) {
      debugPrint("Error loading challenges: $e");
    }
  }

  Future<void> _saveChallenges() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonString = jsonEncode(challenges);
      await prefs.setString('challenges', jsonString);
      _calculateTotalStars();
    } catch (e) {
      debugPrint("Error saving challenges: $e");
    }
  }
void _calculateTotalStars() {
    _totalStars = challenges.fold(0, (int sum, challenge) {
      final starPoints = challenge['starPoints'];
      final points = int.tryParse(starPoints?.toString() ?? '0') ?? 0;
      return sum + points;
    });
  }

  void _addChallenge() {
    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        detailsController.text.isNotEmpty &&
        solutionController.text.isNotEmpty &&
        explanationController.text.isNotEmpty) {
      setState(() {
        challenges.add({
          'title': titleController.text,
          'description': descriptionController.text,
          'challengeDetails': detailsController.text,
          'solution': solutionController.text,
          'explanation': explanationController.text,
          'difficulty': difficulty,
          'starPoints': 0,
          'createdAt': DateTime.now().toIso8601String(),
          'completed': false,
        });
      });
      _saveChallenges();
      _clearControllers();
      Navigator.pop(context);
      _showSuccessSnackbar('Challenge added successfully!');
    } else {
      _showErrorSnackbar('Please fill all fields');
    }
  }

  void _clearControllers() {
    titleController.clear();
    descriptionController.clear();
    detailsController.clear();
    solutionController.clear();
    explanationController.clear();
    difficulty = 'Easy';
  }

  void _deleteChallenge(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Challenge'),
        content: const Text('Are you sure you want to delete this challenge?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                challenges.removeAt(index);
              });
              _saveChallenges();
              Navigator.pop(context);
              _showSuccessSnackbar('Challenge deleted');
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showAddChallengeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Create New Challenge',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('Challenge Title', titleController,
                    hint: 'e.g., Reverse a String'),
                _buildTextField('Description', descriptionController,
                    hint: 'Brief description of the challenge'),
                _buildTextField('Challenge Details', detailsController,
                    hint: 'Detailed problem statement', maxLines: 4),
                _buildTextField('Solution Code', solutionController,
                    hint: 'Your solution code here', maxLines: 6),
                _buildTextField('Explanation', explanationController,
                    hint: 'Explain the solution approach', maxLines: 4),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: difficulty,
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: [
                      _buildDifficultyItem('Easy', Colors.green),
                      _buildDifficultyItem('Medium', Colors.orange),
                      _buildDifficultyItem('Hard', Colors.red),
                    ],
                    onChanged: (value) => setState(() {
                      difficulty = value!;
                    }),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _clearControllers();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addChallenge,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 107, 107, 210),
              ),
              child: const Text('Create Challenge'),
            ),
          ],
        );
      },
    );
  }

  DropdownMenuItem<String> _buildDifficultyItem(String level, Color color) {
    return DropdownMenuItem(
      value: level,
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(level),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {String? hint, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 107, 107, 210)),
          ),
        ),
        maxLines: maxLines,
      ),
    );
  }

  void _showChallengeDetails(int index) {
    final challenge = challenges[index];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              _buildDifficultyChip(challenge['difficulty']),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  challenge['title'],
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  challenge['description'],
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Problem Statement:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(challenge['challengeDetails']),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text('${challenge['starPoints']} stars earned'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showCodeEditor(index, challenge['solution']);
              },
              child: const Text('Start Coding'),
            ),
          ],
        );
      },
    );
  }

  void _showCodeEditor(int index, String solution) {
    final TextEditingController userCodeController = TextEditingController();
    bool isSolutionVisible = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              insetPadding: const EdgeInsets.all(20),
              child: Container(
                constraints: const BoxConstraints(maxHeight: 600),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppBar(
                      title: const Text('Code Editor'),
                      backgroundColor: const Color.fromARGB(255, 107, 107, 210),
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.lightbulb_outline),
                          onPressed: () {
                            setState(() {
                              isSolutionVisible = !isSolutionVisible;
                            });
                          },
                          tooltip: isSolutionVisible
                              ? 'Hide Solution'
                              : 'Show Solution',
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: userCodeController,
                                maxLines: null,
                                expands: true,
                                decoration: const InputDecoration(
                                  hintText: 'Write your solution here...',
                                  border: OutlineInputBorder(),
                                  alignLabelWithHint: true,
                                ),
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.newline,
                              ),
                            ),
                            if (isSolutionVisible) ...[
                              const SizedBox(height: 16),
                              const Text(
                                'Suggested Solution:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: Text(
                                  solution,
                                  style: const TextStyle(
                                    fontFamily: 'Monospace',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                final userCode = userCodeController.text.trim();
                                if (userCode.isEmpty) {
                                  _showErrorSnackbar('Please write some code');
                                  return;
                                }

                                // Simple code validation
                                if (userCode == solution.trim()) {
                                  setState(() {
                                    challenges[index]['starPoints'] =
                                        (challenges[index]['starPoints'] ?? 0) +
                                            1;
                                    challenges[index]['completed'] = true;
                                  });
                                  _saveChallenges();
                                  Navigator.pop(context);
                                  _showSuccessSnackbar(
                                      '🎉 Correct! +1 star earned!');
                                } else {
                                  _showErrorSnackbar(
                                      'Solution not quite right. Keep trying!');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 107, 107, 210),
                              ),
                              child: const Text('Submit Solution'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDifficultyChip(String difficulty) {
    Color color;
    switch (difficulty) {
      case 'Easy':
        color = Colors.green;
        break;
      case 'Medium':
        color = Colors.orange;
        break;
      case 'Hard':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Chip(
      label: Text(
        difficulty,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: color,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Coding Challenges'),
        backgroundColor: const Color.fromARGB(255, 107, 107, 210),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text('$_totalStars'),
              ],
            ),
          ),
        ],
      ),
      body: challenges.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                _buildStatsCard(),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: challenges.length,
                    itemBuilder: (context, index) {
                      final challenge = challenges[index];
                      return ChallengeCard(
                        challenge: challenge,
                        onDelete: () => _deleteChallenge(index),
                        onTap: () => _showChallengeDetails(index),
                        onCodeTap: () =>
                            _showCodeEditor(index, challenge['solution']),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddChallengeDialog,
        backgroundColor: const Color.fromARGB(255, 107, 107, 210),
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.code,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          const Text(
            'No Challenges Yet',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Create your first coding challenge to get started!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _showAddChallengeDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 107, 107, 210),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Create First Challenge'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    final completed = challenges.where((c) => c['completed'] == true).length;
    final total = challenges.length;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6B6BD2), Color(0xFF4A4A9E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total', total.toString(), Icons.list_alt),
          _buildStatItem('Completed', completed.toString(), Icons.check_circle),
          _buildStatItem('Stars', _totalStars.toString(), Icons.star),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class ChallengeCard extends StatelessWidget {
  final Map<String, dynamic> challenge;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final VoidCallback onCodeTap;

  const ChallengeCard({
    Key? key,
    required this.challenge,
    required this.onDelete,
    required this.onTap,
    required this.onCodeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isCompleted = challenge['completed'] == true;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isCompleted ? Colors.green : Colors.grey.shade300,
          width: isCompleted ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      challenge['title'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: isCompleted ? Colors.grey : Colors.black,
                      ),
                    ),
                  ),
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'delete') onDelete();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                challenge['description'],
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildDifficultyChip(challenge['difficulty']),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 4),
                      Text('${challenge['starPoints'] ?? 0}'),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onCodeTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isCompleted
                        ? Colors.green
                        : const Color.fromARGB(255, 107, 107, 210),
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(isCompleted ? Icons.check_circle : Icons.code),
                      const SizedBox(width: 8),
                      Text(isCompleted ? 'Completed' : 'Start Coding'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyChip(String difficulty) {
    Color color;
    switch (difficulty) {
      case 'Easy':
        color = Colors.green;
        break;
      case 'Medium':
        color = Colors.orange;
        break;
      case 'Hard':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Chip(
      label: Text(
        difficulty,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: color,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
