
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class TrackProgressPage extends StatefulWidget {
  const TrackProgressPage({Key? key}) : super(key: key);

  @override
  _TrackProgressPageState createState() => _TrackProgressPageState();
}

class _TrackProgressPageState extends State<TrackProgressPage> {
  List<Map<String, dynamic>> challenges = [];
  final TextEditingController taskController = TextEditingController();
  stt.SpeechToText? _speech; 
  bool _isListening = false;
  String _spokenText = "";

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> saveTasks() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String encodedData = jsonEncode(challenges);
      await prefs.setString('tasks', encodedData);
      debugPrint("Tasks saved successfully: $encodedData");
    } catch (e) {
      debugPrint("Error saving tasks: $e");
    }
  }

  Future<void> loadTasks() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString('tasks');
      if (data != null) {
        setState(() {
          challenges = List<Map<String, dynamic>>.from(jsonDecode(data));
        });
        debugPrint("Tasks loaded successfully: $data");
      } else {
        debugPrint("No tasks found in local storage.");
      }
    } catch (e) {
      debugPrint("Error loading tasks: $e");
    }
  }

  void addTask(String title) {
    setState(() {
      challenges.add({'title': title, 'completed': false});
    });
    saveTasks();
  }

  void toggleCompletion(int index) {
    setState(() {
      challenges[index]['completed'] = !challenges[index]['completed'];
    });
    saveTasks();
  }

  void deleteTask(int index) {
    setState(() {
      challenges.removeAt(index);
    });
    saveTasks();
  }

  double get progress {
    int completedCount =
        challenges.where((challenge) => challenge['completed'] == true).length;
    return challenges.isEmpty ? 0.0 : completedCount / challenges.length;
  }

  List<BarChartGroupData> get barChartData {
    int completedCount =
        challenges.where((challenge) => challenge['completed'] == true).length;
    int remainingCount = challenges.length - completedCount;

    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            fromY: 0, // Starting point of the bar
            toY: completedCount
                .toDouble(), // Ending point of the bar (height of the bar)
            color: Colors.green, // Color of the bar
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            fromY: 0, // Starting point of the bar
            toY: remainingCount
                .toDouble(), // Ending point of the bar (height of the bar)
            color: Colors.red, // Color of the bar
          ),
        ],
      ),
    ];
  }

  void startListening() async {
    if (_speech == null) {
      _speech = stt.SpeechToText(); // Initialize only when needed
    }

    bool available = await _speech!.initialize();
    if (available) {
      setState(() {
        _isListening = true;
      });
      _speech!.listen(onResult: (result) {
        setState(() {
          _spokenText = result.recognizedWords;
        });
      });
    }
  }

  void stopListening() {
    _speech?.stop();
    setState(() {
      _isListening = false;
      if (_spokenText.isNotEmpty) {
        addTask(_spokenText);
        _spokenText = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Your Progress'),
        backgroundColor: const Color.fromARGB(255, 107, 107, 210),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: Colors.grey[300],
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              Text(
                '${(progress * 100).toStringAsFixed(0)}% Completed',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 32),

              // Pie chart for task completion
              SizedBox(
                height: 250,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: progress * 100,
                        color: Colors.green,
                        title: '${(progress * 100).toStringAsFixed(0)}%',
                        radius: 50,
                      ),
                      PieChartSectionData(
                        value: (1 - progress) * 100,
                        color: Colors.red,
                        title: '${((1 - progress) * 100).toStringAsFixed(0)}%',
                        radius: 50,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Bar chart showing completed vs remaining tasks
              SizedBox(
                height: 250,
                child: BarChart(
                  BarChartData(
                    barGroups: barChartData,
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(show: false),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: taskController,
                decoration: const InputDecoration(
                  hintText: 'Add a new task...',
                  border: OutlineInputBorder(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (taskController.text.isNotEmpty) {
                    addTask(taskController.text);
                    taskController.clear();
                  }
                },
              ),

              // Speech-to-Text Button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(_isListening ? Icons.stop : Icons.mic),
                    onPressed: _isListening ? stopListening : startListening,
                  ),
                ],
              ),

              SizedBox(
                height: screenHeight * 0.4,
                child: ListView.builder(
                  itemCount: challenges.length,
                  itemBuilder: (context, index) {
                    final challenge = challenges[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              challenge['title'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: challenge['completed'],
                                  onChanged: (value) {
                                    toggleCompletion(index);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    deleteTask(index);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
