import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _selectedField = 'Engineering';
  final List<String> _fields = [
    'Engineering',
    'Medical',
    'Arts',
    'Science',
    'Business',
    'Other'
  ];

  final Map<String, List<String>> _fieldQuestions = {
    'Engineering': [
      'What is your favorite engineering discipline?',
      'Do you prefer working with hardware or software?'
    ],
    'Medical': [
      'Are you interested in patient care or research?',
      'Which medical specialization excites you?'
    ],
    'Arts': [
      'What type of art inspires you?',
      'Are you interested in visual arts, music, or writing?'
    ],
    'Science': [
      'Which branch of science do you enjoy the most?',
      'Are you inclined toward theoretical or experimental work?'
    ],
    'Business': [
      'Do you enjoy managing teams or working solo?',
      'Which area of business interests you: marketing, finance, or operations?'
    ],
    'Other': [
      'What are your career aspirations?',
      'How do you see your field evolving in the future?'
    ],
  };

  final Map<String, TextEditingController> _dynamicControllers = {};

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dynamicControllers.forEach((key, controller) => controller.dispose());
    super.dispose();
  }

  void _saveProfile() {
    String name = _nameController.text;
    String email = _emailController.text;

    List<String> responses = _fieldQuestions[_selectedField]!
        .map((question) => _dynamicControllers[question]?.text ?? '')
        .toList();

    // Simulate assessment logic
    String assessment =
        'Based on your responses, you are best suited for $_selectedField.';

    // Show a success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profile Saved'),
        content: Text(
          '$assessment\n\nThank you, $name! Your responses have been saved.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Profile'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Basic Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField(
                        value: _selectedField,
                        items: _fields.map((field) {
                          return DropdownMenuItem(
                            value: field,
                            child: Text(field),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedField = value as String;
                            _dynamicControllers.clear();
                            for (var question
                                in _fieldQuestions[_selectedField] ?? []) {
                              _dynamicControllers[question] =
                                  TextEditingController();
                            }
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'Field of Interest',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              if (_fieldQuestions[_selectedField] != null) ...[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Additional Questions',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ..._fieldQuestions[_selectedField]!.map((question) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: TextField(
                              controller: _dynamicControllers[question],
                              decoration: InputDecoration(
                                labelText: question,
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Save Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
