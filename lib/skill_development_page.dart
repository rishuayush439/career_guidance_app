
import 'package:flutter/material.dart';
import 'timer.dart';


class SkillDevelopmentPage extends StatefulWidget {
  const SkillDevelopmentPage({Key? key}) : super(key: key);

  @override
  State<SkillDevelopmentPage> createState() => _SkillDevelopmentPageState();
}

class _SkillDevelopmentPageState extends State<SkillDevelopmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Your Skill'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 54, 127, 182),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SectionTitle(
              title: 'Interactive Skill Challenges', icon: Icons.lightbulb),
          SkillChallengeCard(
            title: 'Daily Coding Challenges',
            description:
                'Practice coding daily with bite-sized challenges to enhance problem-solving skills.',
            callToAction: 'Start Challenge',
            onPressed: () {
              Navigator.pushNamed(context, '/challenge');
            },
          ),
          SkillChallengeCard(
            title: '30-Minute Learning Streak',
            description:
                'Dedicate 30 minutes a day to learning something new about your field.',
            callToAction: 'Set Timer',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TimerPage(),
                ),
              );
            },
          ),
          const SectionTitle(
              title: 'Track Your Progress', icon: Icons.track_changes),
          PersonalSkillTracker(
            title: 'Personal Skill Tracker',
            description:
                'Stay motivated by tracking your progress across various skill areas.',
            onPressed: () {
              Navigator.pushNamed(context, '/trackProgress');
            },
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionTitle({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.indigo),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
        ],
      ),
    );
  }
}

class SkillChallengeCard extends StatelessWidget {
  final String title;
  final String description;
  final String callToAction;
  final VoidCallback onPressed;

  const SkillChallengeCard({
    Key? key,
    required this.title,
    required this.description,
    required this.callToAction,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onPressed,
                child: Text(callToAction),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class PersonalSkillTracker extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onPressed;

  const PersonalSkillTracker({
    Key? key,
    required this.title,
    required this.description,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: onPressed,
                child: const Text('Track Progress'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
