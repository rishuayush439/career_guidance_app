
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

  @override
  void initState() {
    super.initState();
    _loadChallenges();
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
    } catch (e) {
      debugPrint("Error saving challenges: $e");
    }
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
          'starPoints': 0, // Initialize with 0 star points
        });
      });
      _saveChallenges();
      Navigator.pop(context);
    }
  }

  void _deleteChallenge(int index) {
    setState(() {
      challenges.removeAt(index);
    });
    _saveChallenges();
  }

  void _showAddChallengeDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a New Challenge'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('Title', titleController),
                _buildTextField('Description', descriptionController),
                _buildTextField('Challenge Details', detailsController),
                _buildTextField('Solution', solutionController),
                _buildTextField('Explanation', explanationController),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Difficulty'),
                  value: difficulty,
                  items: ['Easy', 'Medium', 'Hard']
                      .map((level) => DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          ))
                      .toList(),
                  onChanged: (value) => setState(() {
                    difficulty = value!;
                  }),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _addChallenge,
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      maxLines: null, 
    );
  }

  void _showCodeEditor(int index, String solution) {
    bool isSolutionVisible = false;
    final TextEditingController userCodeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Code Editor'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Your Code:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextField(
                      controller: userCodeController,
                      maxLines: 10,
                      decoration: const InputDecoration(
                        hintText: 'Write your code here...',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isSolutionVisible = !isSolutionVisible;
                        });
                      },
                      child: Text(isSolutionVisible
                          ? 'Hide Solution'
                          : 'View Solution'),
                    ),
                    if (isSolutionVisible) ...[
                      const SizedBox(height: 16),
                      const Text('Solution:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextField(
                        controller: TextEditingController(text: solution),
                        maxLines: 10,
                        decoration: const InputDecoration(
                          hintText: 'View solution here...',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        readOnly: true, // Make it read-only
                      ),
                    ]
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
                    // Check if the user's code matches the solution
                    if (userCodeController.text.trim() == solution.trim()) {
                      setState(() {
                        challenges[index]['starPoints'] += 1; // Add star point
                      });
                    }
                    debugPrint("Code Submitted: ${userCodeController.text}");
                    Navigator.pop(context);
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Coding Challenges'),
        backgroundColor: const Color.fromARGB(255, 107, 107, 210),
      ),
      body: challenges.isEmpty
          ? const Center(child: Text('No challenges added yet.'))
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: challenges.length,
              itemBuilder: (context, index) {
                final challenge = challenges[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ChallengeCard(
                    challenge: challenge,
                    onDelete: () => _deleteChallenge(index),
                    onCodeTap: () =>
                        _showCodeEditor(index, challenge['solution']),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddChallengeDialog,
        backgroundColor: const Color.fromARGB(255, 107, 107, 210),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ChallengeCard extends StatelessWidget {
  final Map<String, dynamic> challenge;
  final VoidCallback onDelete;
  final VoidCallback onCodeTap;

  const ChallengeCard({
    Key? key,
    required this.challenge,
    required this.onDelete,
    required this.onCodeTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    challenge['title']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
            Text(challenge['description']!),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 20),
                const SizedBox(width: 5),
                Text('${challenge['starPoints']} Star Points'),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: onCodeTap,
              child: const Text('Start Coding'),
            ),
          ],
        ),
      ),
    );
  }
}

