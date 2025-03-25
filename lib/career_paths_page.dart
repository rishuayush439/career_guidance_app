
import 'package:flutter/material.dart';
import 'career_quiz_page.dart';

class CareerPathsPage extends StatelessWidget {
  const CareerPathsPage({Key? key}) : super(key: key);

  void _startCareerQuiz(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CareerQuizPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Career Paths'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _startCareerQuiz(context),
              icon: const Icon(Icons.quiz),
              label: const Text('Take Career Path Quiz'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 215, 214, 227),
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Expanded(
              child: CareerPathList(),
            ),
          ],
        ),
      ),
    );
  }
}

class CareerPathList extends StatelessWidget {
  const CareerPathList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const careerPaths = [
      CareerPathItem(
        title: 'Software Developer',
        description:
            'Explore careers in software development, including web and mobile apps.',
        progression: [
          'Junior Developer',
          'Mid-Level Developer',
          'Senior Developer',
          'Tech Lead',
          'Engineering Manager'
        ],
        skills: [
          'Coding & Programming',
          'System Design',
          'Algorithms',
          'Leadership'
        ],
        nextSteps: {
          'Junior Developer':
              'Focus on mastering foundational coding skills and contribute to small projects.',
          'Mid-Level Developer':
              'Take ownership of projects, improve problem-solving, and mentor juniors.',
          'Senior Developer':
              'Work on system design, scalability, and become a go-to expert.',
          'Tech Lead':
              'Develop leadership skills, guide team projects, and handle client communication.',
        },
        icon: Icons.code,
      ),
      CareerPathItem(
        title: 'Data Scientist',
        description: 'Learn about data science roles and the required skills.',
        progression: [
          'Data Analyst',
          'Data Scientist',
          'Senior Data Scientist',
          'Data Science Manager'
        ],
        skills: [
          'Data Analysis',
          'Machine Learning',
          'Statistics',
          'Data Visualization'
        ],
        nextSteps: {
          'Data Analyst':
              'Learn SQL, Excel, and data visualization tools like Tableau or Power BI.',
          'Data Scientist':
              'Master machine learning algorithms and data preprocessing.',
          'Senior Data Scientist':
              'Lead projects, optimize models, and collaborate with stakeholders.',
          'Data Science Manager':
              'Focus on team management and strategic data-driven decisions.',
        },
        icon: Icons.bar_chart,
      ),
      CareerPathItem(
        title: 'Cybersecurity Specialist',
        description:
            'Dive into cybersecurity roles focused on protecting digital assets.',
        progression: [
          'Security Analyst',
          'Security Engineer',
          'Cybersecurity Architect',
          'Chief Information Security Officer (CISO)'
        ],
        skills: [
          'Network Security',
          'Threat Analysis',
          'Cryptography',
          'Incident Response'
        ],
        nextSteps: {
          'Security Analyst':
              'Monitor security alerts and address potential threats.',
          'Security Engineer':
              'Design and implement secure systems and infrastructure.',
          'Cybersecurity Architect':
              'Plan and build overarching security frameworks.',
          'Chief Information Security Officer (CISO)':
              'Develop organizational security policies and lead security teams.',
        },
        icon: Icons.security,
      ),
      CareerPathItem(
        title: 'Product Manager',
        description:
            'Lead product development and align teams with business goals.',
        progression: [
          'Associate Product Manager',
          'Product Manager',
          'Senior Product Manager',
          'Director of Product'
        ],
        skills: [
          'Market Research',
          'Stakeholder Communication',
          'Roadmap Planning',
          'Agile Methodologies'
        ],
        nextSteps: {
          'Associate Product Manager':
              'Focus on learning product development workflows.',
          'Product Manager':
              'Take ownership of product features and collaborate with teams.',
          'Senior Product Manager':
              'Drive product strategy and oversee cross-functional teams.',
          'Director of Product':
              'Define long-term product vision and manage teams of PMs.',
        },
        icon: Icons.view_compact,
      ),
      CareerPathItem(
        title: 'UX/UI Designer',
        description:
            'Design user interfaces and experiences for web and mobile applications.',
        progression: [
          'Junior Designer',
          'UI/UX Designer',
          'Senior Designer',
          'Design Lead'
        ],
        skills: [
          'Wireframing & Prototyping',
          'User Research',
          'Interaction Design',
          'Visual Design'
        ],
        nextSteps: {
          'Junior Designer':
              'Learn tools like Figma or Adobe XD and work on small projects.',
          'UI/UX Designer':
              'Conduct user research and design intuitive interfaces.',
          'Senior Designer':
              'Lead design projects and mentor junior designers.',
          'Design Lead': 'Develop design strategies and manage design teams.',
        },
        icon: Icons.design_services,
      ),
      CareerPathItem(
        title: 'Digital Marketing Specialist',
        description:
            'Plan and execute digital marketing strategies to boost online presence.',
        progression: [
          'Marketing Intern',
          'Digital Marketing Associate',
          'Marketing Manager',
          'Marketing Director'
        ],
        skills: [
          'SEO & SEM',
          'Social Media Marketing',
          'Content Strategy',
          'Analytics'
        ],
        nextSteps: {
          'Marketing Intern':
              'Assist with basic marketing tasks and learn key tools.',
          'Digital Marketing Associate':
              'Manage campaigns and analyze their performance.',
          'Marketing Manager':
              'Oversee marketing teams and develop marketing strategies.',
          'Marketing Director':
              'Define brand strategies and lead large-scale campaigns.',
        },
        icon: Icons.mark_email_read,
      ),
      CareerPathItem(
        title: 'Mechanical Engineer',
        description: 'Design and build mechanical systems across industries.',
        progression: [
          'Junior Engineer',
          'Mechanical Engineer',
          'Senior Mechanical Engineer',
          'Engineering Manager'
        ],
        skills: [
          'CAD & Modeling',
          'Thermodynamics',
          'Material Science',
          'Project Management'
        ],
        nextSteps: {
          'Junior Engineer':
              'Focus on developing technical and problem-solving skills.',
          'Mechanical Engineer':
              'Design mechanical components and test prototypes.',
          'Senior Mechanical Engineer':
              'Lead engineering projects and optimize designs.',
          'Engineering Manager':
              'Oversee engineering teams and manage project delivery.',
        },
        icon: Icons.build,
      ),

    ];

    return ListView.separated(
      itemCount: careerPaths.length,
      itemBuilder: (context, index) => careerPaths[index],
      separatorBuilder: (context, index) => const SizedBox(height: 12),
    );
  }
}

class CareerPathItem extends StatefulWidget {
  final String title;
  final String description;
  final List<String> progression;
  final List<String> skills;
  final Map<String, String> nextSteps;
  final IconData icon;

  const CareerPathItem({
    Key? key,
    required this.title,
    required this.description,
    required this.progression,
    required this.skills,
    required this.nextSteps,
    required this.icon,
  }) : super(key: key);

  @override
  State<CareerPathItem> createState() => _CareerPathItemState();
}

class _CareerPathItemState extends State<CareerPathItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(widget.icon, size: 40, color: Colors.blueAccent),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(widget.description),
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState: _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: const SizedBox.shrink(),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  const Text(
                    'Career Progression:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  CareerRoadmap(
                    steps: widget.progression,
                    nextSteps: widget.nextSteps,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Suggested Skills:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  ...widget.skills.map((skill) => Text('• $skill')).toList(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Text(_isExpanded ? 'Show Less' : 'Know More'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CareerRoadmap extends StatelessWidget {
  final List<String> steps;
  final Map<String, String> nextSteps;

  const CareerRoadmap({Key? key, required this.steps, required this.nextSteps})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: steps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final String? nextStep =
            index < steps.length - 1 ? steps[index + 1] : null;

        return GestureDetector(
          onTap: nextStep != null && nextSteps.containsKey(step)
              ? () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('From $step to $nextStep'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nextSteps[step] ??
                                'No details available for $step.',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Next Step: $nextStep',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                }
              : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Tooltip(
                    message: step,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: index == 0 ? Colors.green : Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  if (index != steps.length - 1)
                    Container(
                      height: 40,
                      width: 2,
                      color: Colors.blueAccent,
                    ),
                ],
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  step,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}


