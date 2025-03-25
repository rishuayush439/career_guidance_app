import 'package:flutter/material.dart';

class MentorDetailPage extends StatelessWidget {
  final String mentorName;
  final String mentorDetails;

  const MentorDetailPage(
      {Key? key, required this.mentorName, required this.mentorDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mentorName),
        backgroundColor: const Color(0xFF6A11CB),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mentor Details:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(mentorDetails),
            ],
          ),
        ),
      ),
    );
  }
}
