
// import 'package:flutter/material.dart';
// import 'timer.dart';


// class SkillDevelopmentPage extends StatefulWidget {
//   const SkillDevelopmentPage({Key? key}) : super(key: key);

//   @override
//   State<SkillDevelopmentPage> createState() => _SkillDevelopmentPageState();
// }

// class _SkillDevelopmentPageState extends State<SkillDevelopmentPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Test Your Skill'),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 54, 127, 182),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           const SectionTitle(
//               title: 'Interactive Skill Challenges', icon: Icons.lightbulb),
//           SkillChallengeCard(
//             title: 'Daily Coding Challenges',
//             description:
//                 'Practice coding daily with bite-sized challenges to enhance problem-solving skills.',
//             callToAction: 'Start Challenge',
//             onPressed: () {
//               Navigator.pushNamed(context, '/challenge');
//             },
//           ),
//           SkillChallengeCard(
//             title: '30-Minute Learning Streak',
//             description:
//                 'Dedicate 30 minutes a day to learning something new about your field.',
//             callToAction: 'Set Timer',
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const TimerPage(),
//                 ),
//               );
//             },
//           ),
//           const SectionTitle(
//               title: 'Track Your Progress', icon: Icons.track_changes),
//           PersonalSkillTracker(
//             title: 'Personal Skill Tracker',
//             description:
//                 'Stay motivated by tracking your progress across various skill areas.',
//             onPressed: () {
//               Navigator.pushNamed(context, '/trackProgress');
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SectionTitle extends StatelessWidget {
//   final String title;
//   final IconData icon;

//   const SectionTitle({Key? key, required this.title, required this.icon})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 16.0),
//       child: Row(
//         children: [
//           Icon(icon, color: Colors.indigo),
//           const SizedBox(width: 8),
//           Text(
//             title,
//             style: const TextStyle(
//               fontSize: 22,
//               fontWeight: FontWeight.bold,
//               color: Colors.indigo,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SkillChallengeCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final String callToAction;
//   final VoidCallback onPressed;

//   const SkillChallengeCard({
//     Key? key,
//     required this.title,
//     required this.description,
//     required this.callToAction,
//     required this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(description),
//             const SizedBox(height: 12),
//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton(
//                 onPressed: onPressed,
//                 child: Text(callToAction),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// class PersonalSkillTracker extends StatelessWidget {
//   final String title;
//   final String description;
//   final VoidCallback onPressed;

//   const PersonalSkillTracker({
//     Key? key,
//     required this.title,
//     required this.description,
//     required this.onPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0),
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(description),
//             const SizedBox(height: 12),
//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton(
//                 onPressed: onPressed,
//                 child: const Text('Track Progress'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'timer.dart';

class SkillDevelopmentPage extends StatelessWidget {
  const SkillDevelopmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2E),
      appBar: AppBar(
        title: const Text(
          'Skill Development',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF4A6FA5),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF4A6FA5),
              Color(0xFF6B46C1),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Boost Your Skills',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Practice, learn, and track your skill development journey',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Quick Stats
                _buildQuickStats(),
                const SizedBox(height: 32),

                // Interactive Challenges Section
                const Row(
                  children: [
                    Icon(Icons.emoji_events, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Interactive Challenges',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Expanded(
                  child: ListView(
                    children: [
                      SkillChallengeCard(
                        title: 'Daily Coding Challenges',
                        description:
                            'Practice coding daily with bite-sized challenges to enhance problem-solving skills and algorithmic thinking.',
                        icon: Icons.code,
                        color: Colors.blue,
                        progress: 65,
                        level: 'Intermediate',
                        callToAction: 'Start Challenge',
                        onPressed: () {
                          Navigator.pushNamed(context, '/challenge');
                        },
                      ),
                      const SizedBox(height: 16),
                      SkillChallengeCard(
                        title: '30-Minute Learning Streak',
                        description:
                            'Dedicate 30 minutes a day to learning new concepts and building consistent learning habits.',
                        icon: Icons.timer,
                        color: Colors.green,
                        progress: 40,
                        level: 'Beginner',
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
                      const SizedBox(height: 16),
                      SkillChallengeCard(
                        title: 'Progress Tracking',
                        description:
                            'Monitor your skill development, set goals, and track your improvement over time.',
                        icon: Icons.trending_up,
                        color: Colors.orange,
                        progress: 80,
                        level: 'Advanced',
                        callToAction: 'View Progress',
                        onPressed: () {
                          Navigator.pushNamed(context, '/trackProgress');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStats() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('12', 'Challenges', Icons.emoji_events, Colors.blue),
          _buildStatItem('8', 'Skills', Icons.psychology, Colors.green),
          _buildStatItem('15', 'Hours', Icons.timer, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildStatItem(
      String value, String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 24, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class SkillChallengeCard extends StatelessWidget {
  final String title;
  final String description;
  final String callToAction;
  final IconData icon;
  final Color color;
  final int progress;
  final String level;
  final VoidCallback onPressed;

  const SkillChallengeCard({
    Key? key,
    required this.title,
    required this.description,
    required this.callToAction,
    required this.icon,
    required this.color,
    required this.progress,
    required this.level,
    required this.onPressed,
  }) : super(key: key);

  Color _getLevelColor(String level) {
    switch (level.toLowerCase()) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getLevelColor(level).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: _getLevelColor(level).withOpacity(0.3)),
                          ),
                          child: Text(
                            level,
                            style: TextStyle(
                              fontSize: 10,
                              color: _getLevelColor(level),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey[400],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[600],
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),

              // Progress Bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '$progress%',
                        style: TextStyle(
                          fontSize: 12,
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          height: 6,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        Container(
                          height: 6,
                          width: double.infinity,
                          child: FractionallySizedBox(
                            widthFactor: progress / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Action Button
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  ),
                  child: Text(callToAction),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
