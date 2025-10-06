// import 'package:flutter/material.dart';

// class CareerQuizPage extends StatefulWidget {
//   const CareerQuizPage({Key? key}) : super(key: key);

//   @override
//   State<CareerQuizPage> createState() => _CareerQuizPageState();
// }

// class _CareerQuizPageState extends State<CareerQuizPage> {
//   int currentQuestionIndex = 0;
//   int score = 0;
//   bool quizStarted = false;

//   final List<Map<String, Object>> questions = [
//     {
//       'question': 'Do you enjoy solving logical problems?',
//       'choices': [
//         {'text': 'Yes, very much', 'score': 3},
//         {'text': 'Somewhat', 'score': 2},
//         {'text': 'No', 'score': 0},
//       ],
//     },
//     {
//       'question': 'Are you interested in creating visual content or designing?',
//       'choices': [
//         {'text': 'Yes, I love it', 'score': 3},
//         {'text': 'Somewhat', 'score': 2},
//         {'text': 'No', 'score': 0},
//       ],
//     },
//     {
//       'question': 'Do you enjoy coding or programming?',
//       'choices': [
//         {'text': 'Yes, it excites me!', 'score': 3},
//         {'text': 'I am interested but not experienced yet', 'score': 2},
//         {'text': 'No, not my area', 'score': 0},
//       ],
//     },
//     {
//       'question': 'Are you passionate about managing projects or teams?',
//       'choices': [
//         {'text': 'Yes, I enjoy leading', 'score': 3},
//         {'text': 'Sometimes, depending on the team', 'score': 2},
//         {'text': 'No, I prefer working solo', 'score': 0},
//       ],
//     },
//     {
//       'question': 'Do you enjoy analyzing data or finding patterns?',
//       'choices': [
//         {'text': 'Yes, I love working with data', 'score': 3},
//         {'text': 'It is interesting, but challenging', 'score': 2},
//         {'text': 'No, I prefer creative work', 'score': 0},
//       ],
//     },
//     {
//       'question': 'Do you like public speaking or presenting ideas?',
//       'choices': [
//         {'text': 'Yes, I enjoy it', 'score': 3},
//         {'text': 'Sometimes, depending on the topic', 'score': 2},
//         {'text': 'No, I avoid it', 'score': 0},
//       ],
//     },
//     {
//       'question':
//           'Are you curious about Artificial Intelligence or Machine Learning?',
//       'choices': [
//         {'text': 'Yes, I am very interested', 'score': 3},
//         {'text': 'Somewhat, but it seems complex', 'score': 2},
//         {'text': 'Not really', 'score': 0},
//       ],
//     },
//     {
//       'question': 'Do you enjoy writing or creating content?',
//       'choices': [
//         {'text': 'Yes, I love expressing ideas', 'score': 3},
//         {'text': 'Sometimes, but I need inspiration', 'score': 2},
//         {'text': 'Not at all', 'score': 0},
//       ],
//     },
//     {
//       'question':
//           'Do you enjoy working with people in collaborative environments?',
//       'choices': [
//         {'text': 'Yes, teamwork energizes me', 'score': 3},
//         {'text': 'Sometimes, but I prefer balance', 'score': 2},
//         {'text': 'No, I work better alone', 'score': 0},
//       ],
//     },
//     {
//       'question': 'Do you like solving business or market challenges?',
//       'choices': [
//         {'text': 'Yes, I love strategic thinking', 'score': 3},
//         {'text': 'Somewhat, but it is not my focus', 'score': 2},
//         {'text': 'No, I prefer technical work', 'score': 0},
//       ],
//     },
//     {
//       'question': 'Are you interested in healthcare or helping others?',
//       'choices': [
//         {'text': 'Yes, I am passionate about it', 'score': 3},
//         {'text': 'Somewhat, but not a priority', 'score': 2},
//         {'text': 'No, I am not interested', 'score': 0},
//       ],
//     },
//     {
//       'question': 'Do you enjoy working with hardware or machinery?',
//       'choices': [
//         {'text': 'Yes, I like building things', 'score': 3},
//         {'text': 'Somewhat, but I prefer software', 'score': 2},
//         {'text': 'No, not at all', 'score': 0},
//       ],
//     },
//   ];

//   String getCareerSuggestion() {
//     if (score >= 30) {
//       return 'Data Scientist, Software Engineer, AI/ML Specialist\n\n'
//           'You excel in logical and analytical thinking, making you ideal for cutting-edge tech fields.';
//     } else if (score >= 25) {
//       return 'Product Manager, Cybersecurity Expert, Entrepreneur\n\n'
//           'Your leadership and strategic thinking make you a natural for innovative roles.';
//     } else if (score >= 20) {
//       return 'UI/UX Designer, Content Creator, Digital Marketer\n\n'
//           'Your creativity and communication skills shine in visual and media-focused careers.';
//     } else if (score >= 15) {
//       return 'Healthcare Professional, Educator, or Social Worker\n\n'
//           'You show empathy and organizational skills suitable for helping professions.';
//     } else {
//       return 'Technician, Customer Support Specialist, or Administrative Roles\n\n'
//           'Consider careers where attention to detail and structure matter most.';
//     }
//   }

//   void _answerQuestion(int scoreValue) {
//     setState(() {
//       score += scoreValue;
//       currentQuestionIndex += 1;
//     });
//   }

//   void _restartQuiz() {
//     setState(() {
//       score = 0;
//       currentQuestionIndex = 0;
//       quizStarted = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Career Quiz'),
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color.fromARGB(255, 83, 124, 195), Color.fromARGB(255, 200, 140, 140)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: quizStarted
//               ? currentQuestionIndex < questions.length
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         LinearProgressIndicator(
//                           value: (currentQuestionIndex + 1) / questions.length,
//                           color: const Color.fromARGB(255, 183, 54, 15),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           'Score: $score',
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Color.fromARGB(255, 107, 29, 95),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Text(
//                           'Question ${currentQuestionIndex + 1}/${questions.length}',
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Card(
//                           elevation: 5,
//                           margin: const EdgeInsets.symmetric(vertical: 10),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16.0),
//                             child: Text(
//                               questions[currentQuestionIndex]['question']
//                                   as String,
//                               style: const TextStyle(fontSize: 20),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         ...(questions[currentQuestionIndex]['choices']
//                                 as List<Map<String, Object>>)
//                             .map((choice) {
//                           return ElevatedButton(
//                             onPressed: () =>
//                                 _answerQuestion(choice['score'] as int),
//                             child: Text(choice['text'] as String),
//                           );
//                         }).toList(),
//                       ],
//                     )
//                   : Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'Quiz Completed!',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Text(
//                           'Your Final Score: $score',
//                           style: const TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             color: Color.fromARGB(255, 181, 34, 41),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         Container(
//                           padding: const EdgeInsets.all(16.0),
//                           margin: const EdgeInsets.symmetric(horizontal: 16.0),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 5,
//                                 blurRadius: 7,
//                                 offset: const Offset(0, 3),
//                               ),
//                             ],
//                           ),
//                           child: Text(
//                             getCareerSuggestion(),
//                             style: const TextStyle(
//                               fontSize: 18,
//                               color: Color.fromARGB(255, 71, 104, 160),
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         const SizedBox(height:20),
//                         ElevatedButton(
//                           onPressed: _restartQuiz,
//                           child: const Text('Retake Quiz'),
//                         ),
//                       ],
//                     )
//               : Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'Welcome to the Career Quiz!',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() => quizStarted = true);
//                         },
//                         child: const Text('Start Quiz'),
//                       ),
//                     ],
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class CareerQuizPage extends StatefulWidget {
  const CareerQuizPage({Key? key}) : super(key: key);

  @override
  State<CareerQuizPage> createState() => _CareerQuizPageState();
}

class _CareerQuizPageState extends State<CareerQuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool quizStarted = false;
  bool quizCompleted = false;
  List<int> selectedAnswers = [];

  final List<Map<String, Object>> questions = [
    {
      'question': 'Do you enjoy solving logical problems?',
      'category': 'Analytical Thinking',
      'choices': [
        {'text': 'Yes, very much', 'score': 3},
        {'text': 'Somewhat', 'score': 2},
        {'text': 'No', 'score': 0},
      ],
    },
    {
      'question': 'Are you interested in creating visual content or designing?',
      'category': 'Creativity',
      'choices': [
        {'text': 'Yes, I love it', 'score': 3},
        {'text': 'Somewhat', 'score': 2},
        {'text': 'No', 'score': 0},
      ],
    },
    {
      'question': 'Do you enjoy coding or programming?',
      'category': 'Technical',
      'choices': [
        {'text': 'Yes, it excites me!', 'score': 3},
        {'text': 'I am interested but not experienced yet', 'score': 2},
        {'text': 'No, not my area', 'score': 0},
      ],
    },
    {
      'question': 'Are you passionate about managing projects or teams?',
      'category': 'Leadership',
      'choices': [
        {'text': 'Yes, I enjoy leading', 'score': 3},
        {'text': 'Sometimes, depending on the team', 'score': 2},
        {'text': 'No, I prefer working solo', 'score': 0},
      ],
    },
    {
      'question': 'Do you enjoy analyzing data or finding patterns?',
      'category': 'Analytical Thinking',
      'choices': [
        {'text': 'Yes, I love working with data', 'score': 3},
        {'text': 'It is interesting, but challenging', 'score': 2},
        {'text': 'No, I prefer creative work', 'score': 0},
      ],
    },
    {
      'question': 'Do you like public speaking or presenting ideas?',
      'category': 'Communication',
      'choices': [
        {'text': 'Yes, I enjoy it', 'score': 3},
        {'text': 'Sometimes, depending on the topic', 'score': 2},
        {'text': 'No, I avoid it', 'score': 0},
      ],
    },
  ];

  Map<String, dynamic> getCareerSuggestion() {
    if (score >= 15) {
      return {
        'title': 'Technology & Innovation Roles',
        'description': 'Data Scientist, Software Engineer, AI/ML Specialist\n\n'
            'You excel in logical and analytical thinking, making you ideal for cutting-edge tech fields that require problem-solving and innovation.',
        'icon': '💻',
        'color': Colors.blue,
      };
    } else if (score >= 12) {
      return {
        'title': 'Leadership & Strategic Roles',
        'description': 'Product Manager, Cybersecurity Expert, Entrepreneur\n\n'
            'Your leadership and strategic thinking make you a natural for innovative roles that require vision and decision-making.',
        'icon': '🚀',
        'color': Colors.green,
      };
    } else if (score >= 9) {
      return {
        'title': 'Creative & Communication Roles',
        'description': 'UI/UX Designer, Content Creator, Digital Marketer\n\n'
            'Your creativity and communication skills shine in visual and media-focused careers that require artistic expression.',
        'icon': '🎨',
        'color': Colors.purple,
      };
    } else if (score >= 6) {
      return {
        'title': 'Helping & Service Professions',
        'description': 'Healthcare Professional, Educator, Social Worker\n\n'
            'You show empathy and organizational skills suitable for helping professions that make a difference in people\'s lives.',
        'icon': '❤️',
        'color': Colors.red,
      };
    } else {
      return {
        'title': 'Technical & Support Roles',
        'description':
            'Technician, Customer Support Specialist, Administrative Roles\n\n'
                'Consider careers where attention to detail, structure, and reliability matter most.',
        'icon': '🔧',
        'color': Colors.orange,
      };
    }
  }

  void _answerQuestion(int scoreValue, int choiceIndex) {
    setState(() {
      score += scoreValue;
      selectedAnswers.add(choiceIndex);
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex += 1;
      } else {
        quizCompleted = true;
      }
    });
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        // Subtract the previous answer's score
        int previousChoiceIndex = selectedAnswers[currentQuestionIndex - 1];
        int previousScore = (questions[currentQuestionIndex - 1]['choices']
            as List<Map<String, Object>>)[previousChoiceIndex]['score'] as int;
        score -= previousScore;
        selectedAnswers.removeLast();
        currentQuestionIndex -= 1;
      });
    }
  }

  void _restartQuiz() {
    setState(() {
      score = 0;
      currentQuestionIndex = 0;
      quizStarted = false;
      quizCompleted = false;
      selectedAnswers.clear();
    });
  }

  void _startQuiz() {
    setState(() {
      quizStarted = true;
      quizCompleted = false;
      score = 0;
      currentQuestionIndex = 0;
      selectedAnswers.clear();
    });
  }

  Widget _buildWelcomeScreen() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.quiz,
              size: 80,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Text(
              'Discover Your Ideal Career',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Take this short quiz to explore career paths that match your interests and strengths',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                onPressed: _startQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF4A6FA5),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Start Career Quiz',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // Show quiz info
                _showQuizInfo();
              },
              child: const Text(
                'About This Quiz',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showQuizInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About the Career Quiz'),
        content:  Text(
          'This quiz consists of ${questions.length} questions designed to help you discover career paths that align with your interests, skills, and preferences.\n\n'
          'There are no right or wrong answers - be honest about your preferences for the most accurate results!',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizScreen() {
    final currentQuestion = questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / questions.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Progress section
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1}/${questions.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Score: $score',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.white.withOpacity(0.3),
                color: Colors.white,
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
              const SizedBox(height: 8),
              Text(
                '${(progress * 100).round()}% Complete',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Question card
        Card(
          elevation: 8,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A6FA5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    currentQuestion['category'] as String,
                    style: const TextStyle(
                      color: Color(0xFF4A6FA5),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  currentQuestion['question'] as String,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Choices
        Expanded(
          child: ListView.separated(
            itemCount: (currentQuestion['choices'] as List).length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final choice = (currentQuestion['choices']
                  as List<Map<String, Object>>)[index];
              return ChoiceCard(
                text: choice['text'] as String,
                onTap: () => _answerQuestion(choice['score'] as int, index),
                index: index,
              );
            },
          ),
        ),

        // Navigation buttons
        if (currentQuestionIndex > 0) ...[
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: _previousQuestion,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Previous Question'),
          ),
        ],
      ],
    );
  }

  Widget _buildResultsScreen() {
    final career = getCareerSuggestion();

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.celebration,
            size: 80,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          const Text(
            'Quiz Completed!',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your Final Score: $score',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 40),

          // Career suggestion card
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: career['color'] as Color? ?? Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          career['icon']!,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      career['title']!,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      career['description']!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF4A5568),
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Action buttons
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _restartQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF4A6FA5),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Retake Quiz',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    // Share results functionality
                    _shareResults();
                  },
                  child: const Text(
                    'Share Results',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
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

  void _shareResults() {
    // Implement share functionality
    final career = getCareerSuggestion();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Share Your Results'),
        content: Text(
            'Share your career suggestion: ${career['title']}\n\nScore: $score'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Career Quiz',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF4A6FA5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF4A6FA5),
              Color(0xFF6B46C1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: !quizStarted
                ? _buildWelcomeScreen()
                : !quizCompleted
                    ? _buildQuizScreen()
                    : _buildResultsScreen(),
          ),
        ),
      ),
    );
  }
}

class ChoiceCard extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final int index;

  const ChoiceCard({
    Key? key,
    required this.text,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: const Color(0xFF4A6FA5).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    String.fromCharCode(65 + index), // A, B, C, etc.
                    style: const TextStyle(
                      color: Color(0xFF4A6FA5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

