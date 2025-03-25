
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; 
import 'mentorDetail.dart'; 

class GetGuidancePage extends StatefulWidget {
  const GetGuidancePage({Key? key}) : super(key: key);

  @override
  _GetGuidancePageState createState() => _GetGuidancePageState();
}

class _GetGuidancePageState extends State<GetGuidancePage> {
  final List<String> _mentors = [
    'Aniket Joseph',
    'Animesh Goenka',
    'Mohit Goenka',
    'Anmol Singhania',
    'Arjun Reddy'
  ];

  final Map<String, String> _mentorDetails = {
    'Aniket Joseph': 'Aniket is a career coach with 10 years of experience in IT. \n'
        'Qualifications: MBA in IT Management. \n'
        'Specialties: Resume building, career guidance, and interview preparation. \n'
        'Achievements: Helped over 500 students land jobs in top IT firms. \n'
        'Key Skills: Strategic planning, mentorship, and personal branding.',
    'Animesh Goenka':
        'Animesh specializes in AI and Machine Learning with 7 years of expertise. \n'
            'Qualifications: PhD in Artificial Intelligence. \n'
            'Specialties: Neural networks, data analysis, and AI project development. \n'
            'Achievements: Published 15+ research papers in international journals. \n'
            'Key Skills: Python, TensorFlow, and research methodologies.',
    'Mohit Goenka':
        'Mohit is a web development mentor with 8 years of industry experience. \n'
            'Qualifications: B.Tech in Computer Science. \n'
            'Specialties: Full-stack web development, modern web technologies, and UI/UX design. \n'
            'Achievements: Developed over 50 successful web projects for clients. \n'
            'Key Skills: JavaScript, React, Node.js, and cloud services.',
    'Anmol Singhania':
        'Anmol is a soft skills and communication coach with 5 years of training experience. \n'
            'Qualifications: Certified Corporate Trainer. \n'
            'Specialties: Leadership training, public speaking, and interpersonal skills. \n'
            'Achievements: Conducted over 200 workshops with excellent feedback. \n'
            'Key Skills: Communication strategies, team building, and problem-solving.',
    'Arjun Reddy':
        'Arjun is a renowned expert in programming with extensive experience in creating startups. \n'
            'Qualifications: B.Tech in Computer Science. \n'
            'Specialties: Competitive programming, startup mentoring, and product development. \n'
            'Achievements: Founded 3 successful startups and mentored over 100 programmers. \n'
            'Key Skills: Algorithms, system design, and entrepreneurship.'
  };

  Map<String, String> _assignedStudents = {};
  String? _selectedMentor;
  final TextEditingController _studentController = TextEditingController();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadAssignedMentors();
  }

  Future<void> _loadAssignedMentors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('assignedStudents');
    if (data != null) {
      setState(() {
        _assignedStudents = Map<String, String>.from(json.decode(data));
      });
    }
  }

  Future<void> _saveAssignedMentors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('assignedStudents', json.encode(_assignedStudents));
  }

  void _assignMentor() {
    String studentName = _studentController.text.trim();
    if (studentName.isEmpty || _selectedMentor == null) {
      setState(() {
        _errorMessage = 'Please enter a student name and select a mentor.';
      });
      return;
    }

    setState(() {
      _assignedStudents[studentName] = _selectedMentor!;
      _errorMessage = null;
      _studentController.clear();
      _selectedMentor = null;
    });

    _saveAssignedMentors();
  }

  void _deleteAssignment(String student) {
    setState(() {
      _assignedStudents.remove(student);
    });

    _saveAssignedMentors();
  }

  void _confirmDelete(String student) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Assignment'),
        content: Text(
            'Are you sure you want to remove the mentor assignment for $student?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteAssignment(student);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          'Assign Mentor',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Select a Mentor: ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        value: _selectedMentor,
                        hint: const Text('Choose a mentor'),
                        items: _mentors.map((mentor) {
                          return DropdownMenuItem(
                            value: mentor,
                            child: Row(
                              children: [
                                const Icon(Icons.person, color: Colors.blue),
                                const SizedBox(width: 10),
                                Text(mentor),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedMentor = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _studentController,
                        decoration: InputDecoration(
                          labelText: 'Enter Student Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: const Icon(Icons.school),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (_errorMessage != null)
                        Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _assignMentor,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6A11CB),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Center(
                          child: Text(
                            'Assign Mentor',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Assigned Students:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const SizedBox(height: 10),
              _assignedStudents.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: _assignedStudents.keys.length,
                      itemBuilder: (context, index) {
                        String studentName =
                            _assignedStudents.keys.elementAt(index);
                        String mentorName = _assignedStudents[studentName]!;
                        return ListTile(
                          title: Text(studentName),
                          subtitle: Text('Mentor: $mentorName'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _confirmDelete(studentName),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MentorDetailPage(
                                  mentorName: mentorName,
                                  mentorDetails: _mentorDetails[mentorName]!,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  : const Text('No students assigned yet.'),
            ],
          ),
        ),
      ),
    );
  }
}


