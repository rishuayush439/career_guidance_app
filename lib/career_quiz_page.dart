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

  final List<Map<String, Object>> questions = [
    {
      'question': 'Do you enjoy solving logical problems?',
      'choices': [
        {'text': 'Yes, very much', 'score': 3},
        {'text': 'Somewhat', 'score': 2},
        {'text': 'No', 'score': 0},
      ],
    },
    {
      'question': 'Are you interested in creating visual content or designing?',
      'choices': [
        {'text': 'Yes, I love it', 'score': 3},
        {'text': 'Somewhat', 'score': 2},
        {'text': 'No', 'score': 0},
      ],
    },
    {
      'question': 'Do you enjoy coding or programming?',
      'choices': [
        {'text': 'Yes, it excites me!', 'score': 3},
        {'text': 'I am interested but not experienced yet', 'score': 2},
        {'text': 'No, not my area', 'score': 0},
      ],
    },
    {
      'question': 'Are you passionate about managing projects or teams?',
      'choices': [
        {'text': 'Yes, I enjoy leading', 'score': 3},
        {'text': 'Sometimes, depending on the team', 'score': 2},
        {'text': 'No, I prefer working solo', 'score': 0},
      ],
    },
    {
      'question': 'Do you enjoy analyzing data or finding patterns?',
      'choices': [
        {'text': 'Yes, I love working with data', 'score': 3},
        {'text': 'It is interesting, but challenging', 'score': 2},
        {'text': 'No, I prefer creative work', 'score': 0},
      ],
    },
    {
      'question': 'Do you like public speaking or presenting ideas?',
      'choices': [
        {'text': 'Yes, I enjoy it', 'score': 3},
        {'text': 'Sometimes, depending on the topic', 'score': 2},
        {'text': 'No, I avoid it', 'score': 0},
      ],
    },
    {
      'question':
          'Are you curious about Artificial Intelligence or Machine Learning?',
      'choices': [
        {'text': 'Yes, I am very interested', 'score': 3},
        {'text': 'Somewhat, but it seems complex', 'score': 2},
        {'text': 'Not really', 'score': 0},
      ],
    },
    {
      'question': 'Do you enjoy writing or creating content?',
      'choices': [
        {'text': 'Yes, I love expressing ideas', 'score': 3},
        {'text': 'Sometimes, but I need inspiration', 'score': 2},
        {'text': 'Not at all', 'score': 0},
      ],
    },
    {
      'question':
          'Do you enjoy working with people in collaborative environments?',
      'choices': [
        {'text': 'Yes, teamwork energizes me', 'score': 3},
        {'text': 'Sometimes, but I prefer balance', 'score': 2},
        {'text': 'No, I work better alone', 'score': 0},
      ],
    },
    {
      'question': 'Do you like solving business or market challenges?',
      'choices': [
        {'text': 'Yes, I love strategic thinking', 'score': 3},
        {'text': 'Somewhat, but it is not my focus', 'score': 2},
        {'text': 'No, I prefer technical work', 'score': 0},
      ],
    },
    {
      'question': 'Are you interested in healthcare or helping others?',
      'choices': [
        {'text': 'Yes, I am passionate about it', 'score': 3},
        {'text': 'Somewhat, but not a priority', 'score': 2},
        {'text': 'No, I am not interested', 'score': 0},
      ],
    },
    {
      'question': 'Do you enjoy working with hardware or machinery?',
      'choices': [
        {'text': 'Yes, I like building things', 'score': 3},
        {'text': 'Somewhat, but I prefer software', 'score': 2},
        {'text': 'No, not at all', 'score': 0},
      ],
    },
  ];

  String getCareerSuggestion() {
    if (score >= 30) {
      return 'Data Scientist, Software Engineer, AI/ML Specialist\n\n'
          'You excel in logical and analytical thinking, making you ideal for cutting-edge tech fields.';
    } else if (score >= 25) {
      return 'Product Manager, Cybersecurity Expert, Entrepreneur\n\n'
          'Your leadership and strategic thinking make you a natural for innovative roles.';
    } else if (score >= 20) {
      return 'UI/UX Designer, Content Creator, Digital Marketer\n\n'
          'Your creativity and communication skills shine in visual and media-focused careers.';
    } else if (score >= 15) {
      return 'Healthcare Professional, Educator, or Social Worker\n\n'
          'You show empathy and organizational skills suitable for helping professions.';
    } else {
      return 'Technician, Customer Support Specialist, or Administrative Roles\n\n'
          'Consider careers where attention to detail and structure matter most.';
    }
  }

  void _answerQuestion(int scoreValue) {
    setState(() {
      score += scoreValue;
      currentQuestionIndex += 1;
    });
  }

  void _restartQuiz() {
    setState(() {
      score = 0;
      currentQuestionIndex = 0;
      quizStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Career Quiz'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 83, 124, 195), Color.fromARGB(255, 200, 140, 140)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: quizStarted
              ? currentQuestionIndex < questions.length
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LinearProgressIndicator(
                          value: (currentQuestionIndex + 1) / questions.length,
                          color: const Color.fromARGB(255, 183, 54, 15),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Score: $score',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 107, 29, 95),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Question ${currentQuestionIndex + 1}/${questions.length}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Card(
                          elevation: 5,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              questions[currentQuestionIndex]['question']
                                  as String,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...(questions[currentQuestionIndex]['choices']
                                as List<Map<String, Object>>)
                            .map((choice) {
                          return ElevatedButton(
                            onPressed: () =>
                                _answerQuestion(choice['score'] as int),
                            child: Text(choice['text'] as String),
                          );
                        }).toList(),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Quiz Completed!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Your Final Score: $score',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 181, 34, 41),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Text(
                            getCareerSuggestion(),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 71, 104, 160),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height:20),
                        ElevatedButton(
                          onPressed: _restartQuiz,
                          child: const Text('Retake Quiz'),
                        ),
                      ],
                    )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Welcome to the Career Quiz!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          setState(() => quizStarted = true);
                        },
                        child: const Text('Start Quiz'),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

