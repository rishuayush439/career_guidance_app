

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart'; 

// class TimerPage extends StatefulWidget {
//   const TimerPage({Key? key}) : super(key: key);

//   @override
//   State<TimerPage> createState() => _TimerPageState();
// }

// class _TimerPageState extends State<TimerPage> {
//   int _seconds = 30 * 60; 
//   int _initialSeconds = 30 * 60; 
//   Timer? _timer;
//   bool _isTimerRunning = false;
//   TextEditingController _controller = TextEditingController();
//   final AudioPlayer _audioPlayer = AudioPlayer(); 

//   void _startTimer() {
//     if (_timer != null) {
//       _timer!.cancel();
//     }
//     setState(() {
//       _isTimerRunning = true;
//     });
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_seconds > 0) {
//           _seconds--;
//         } else {
//           timer.cancel();
//           _isTimerRunning = false;
//           _playAlarm(); // Play alarm when timer ends
//           _showCompletionDialog();
//         }
//       });
//     });
//   }

//   void _pauseTimer() {
//     if (_timer != null) {
//       _timer!.cancel();
//     }
//     setState(() {
//       _isTimerRunning = false;
//     });
//   }

//   void _resetTimer() {
//     if (_timer != null) {
//       _timer!.cancel();
//     }
//     setState(() {
//       _seconds = int.tryParse(_controller.text) ??
//           30 * 60; // Reset to input time or 30 minutes
//       _initialSeconds = _seconds; // Reset initial time for progress calculation
//       _isTimerRunning = false;
//     });
//   }

//   void _showCompletionDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Time Up!'),
//         content:
//             const Text('Congratulations on completing your learning session!'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }

//   // Method to play the alarm sound
//   void _playAlarm() async {
//     try {
//       await _audioPlayer.play(
//           AssetSource('alarm_sound.wav')); 
//     } catch (e) {
//       debugPrint('Error playing alarm sound: $e');
//     }
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _audioPlayer.dispose(); 
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final minutes = _seconds ~/ 60;
//     final seconds = _seconds % 60;
//     final progress = (_seconds / _initialSeconds);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Set Timer'),
//         backgroundColor: const Color.fromARGB(255, 107, 107, 210),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
           
//             TextField(
//               controller: _controller,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: 'Enter time in seconds',
//                 border: OutlineInputBorder(),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide:
//                       BorderSide(color: Color.fromARGB(255, 230, 100, 53)),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),

//             ElevatedButton(
//               onPressed: _resetTimer,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color.fromARGB(255, 233, 202, 92),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: const Text('Set Timer'),
//             ),
//             const SizedBox(height: 20),

//             Text(
//               '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
//               style: const TextStyle(
//                 fontSize: 48,
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(255, 107, 107, 210),
//               ),
//             ),
//             const SizedBox(height: 20),

//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ElevatedButton(
//                       onPressed: _isTimerRunning ? null : _startTimer,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             const Color.fromARGB(255, 131, 222, 134),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text('Start Timer'),
//                     ),
//                     const SizedBox(width: 20),
//                     ElevatedButton(
//                       onPressed: _isTimerRunning ? _pauseTimer : null,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             const Color.fromARGB(255, 121, 166, 211),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text('Pause Timer'),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ElevatedButton(
//                       onPressed: _resetTimer,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor:
//                             const Color.fromARGB(255, 233, 100, 90),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       child: const Text('Reset Timer'),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 if (_isTimerRunning)
//                   LinearProgressIndicator(
//                     value: progress,
//                     color: const Color.fromARGB(255, 210, 135, 37),
//                     backgroundColor: Colors.grey[300],
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _seconds = 30 * 60;
  int _initialSeconds = 30 * 60;
  Timer? _timer;
  bool _isTimerRunning = false;
  final TextEditingController _controller = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isAlarmPlaying = false;

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _isTimerRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          timer.cancel();
          _isTimerRunning = false;
          _playAlarm(); // Play alarm when timer ends
          _showCompletionDialog();
        }
      });
    });
  }

  void _pauseTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _isTimerRunning = false;
    });
  }

  void _resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    // Parse input and validate
    final inputSeconds = int.tryParse(_controller.text);
    final newSeconds = (inputSeconds ?? 30 * 60);

    // Ensure minimum 1 second and reasonable maximum (24 hours)
    final validatedSeconds = newSeconds.clamp(1, 24 * 60 * 60);

    setState(() {
      _seconds = validatedSeconds;
      _initialSeconds = validatedSeconds;
      _isTimerRunning = false;
    });

    // Stop alarm if playing
    if (_isAlarmPlaying) {
      _stopAlarm();
    }
  }

  void _setCustomTime() {
    final inputSeconds = int.tryParse(_controller.text);
    if (inputSeconds == null || inputSeconds <= 0) {
      _showErrorDialog(
          'Please enter a valid time in seconds (minimum 1 second)');
      return;
    }

    if (inputSeconds > 24 * 60 * 60) {
      _showErrorDialog('Maximum time limit is 24 hours (86400 seconds)');
      return;
    }

    setState(() {
      _seconds = inputSeconds;
      _initialSeconds = inputSeconds;
      _isTimerRunning = false;
    });

    _controller.clear();
    _showSuccessSnackbar('Timer set to ${_formatTime(inputSeconds)}');
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.timer, color: Colors.green),
            SizedBox(width: 8),
            Text('Time Up!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Congratulations on completing your learning session!'),
            const SizedBox(height: 16),
            if (_isAlarmPlaying)
              ElevatedButton.icon(
                onPressed: _stopAlarm,
                icon: const Icon(Icons.stop),
                label: const Text('Stop Alarm'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_isAlarmPlaying) {
                _stopAlarm();
              }
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invalid Input'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Method to play the alarm sound
  void _playAlarm() async {
    try {
      setState(() {
        _isAlarmPlaying = true;
      });
      await _audioPlayer.play(AssetSource('alarm_sound.wav'));
    } catch (e) {
      debugPrint('Error playing alarm sound: $e');
      setState(() {
        _isAlarmPlaying = false;
      });
    }
  }

  void _stopAlarm() async {
    try {
      await _audioPlayer.stop();
      setState(() {
        _isAlarmPlaying = false;
      });
    } catch (e) {
      debugPrint('Error stopping alarm: $e');
    }
  }

  String _formatTime(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  void _addTime(int secondsToAdd) {
    setState(() {
      _seconds = (_seconds + secondsToAdd).clamp(0, 24 * 60 * 60);
      if (!_isTimerRunning) {
        _initialSeconds = _seconds;
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _seconds ~/ 60;
    final seconds = _seconds % 60;
    final progress =
        _initialSeconds > 0 ? (1 - (_seconds / _initialSeconds)) : 0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Timer'),
        backgroundColor: const Color.fromARGB(255, 107, 107, 210),
        actions: [
          if (_isAlarmPlaying)
            IconButton(
              icon: const Icon(Icons.stop, color: Colors.red),
              onPressed: _stopAlarm,
              tooltip: 'Stop Alarm',
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Timer Display
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey[300]!),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      _formatTime(_seconds),
                      style: TextStyle(
                        fontSize: 42, // Reduced for smaller screens
                        fontWeight: FontWeight.bold,
                        color: _seconds <= 60
                            ? Colors.red
                            : const Color.fromARGB(255, 107, 107, 210),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _isTimerRunning ? 'Running...' : 'Paused',
                      style: TextStyle(
                        fontSize: 14,
                        color: _isTimerRunning ? Colors.green : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Progress Indicator
              if (_isTimerRunning) ...[
                LinearProgressIndicator(
                  value: progress.toDouble(),
                  color: _getProgressColor(progress.toDouble()),
                  backgroundColor: Colors.grey[300],
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 8),
                Text(
                  '${(progress * 100).toStringAsFixed(1)}% Complete',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Quick Time Buttons
              const Text(
                'Quick Set:',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildQuickTimeButton('5 min', 5 * 60),
                  _buildQuickTimeButton('15 min', 15 * 60),
                  _buildQuickTimeButton('30 min', 30 * 60),
                  _buildQuickTimeButton('1 hour', 60 * 60),
                ],
              ),

              const SizedBox(height: 20),

              // Custom Time Input
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Custom Time:',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Seconds',
                                border: OutlineInputBorder(),
                                hintText: '1800 for 30 min',
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                isDense: true,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _setCustomTime,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 107, 107, 210),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
                            child: const Text('Set'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Control Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton(
                    icon: Icons.play_arrow,
                    label: 'Start',
                    color: Colors.green,
                    onPressed: _isTimerRunning ? null : _startTimer,
                  ),
                  _buildControlButton(
                    icon: Icons.pause,
                    label: 'Pause',
                    color: Colors.orange,
                    onPressed: _isTimerRunning ? _pauseTimer : null,
                  ),
                  _buildControlButton(
                    icon: Icons.refresh,
                    label: 'Reset',
                    color: Colors.red,
                    onPressed: _resetTimer,
                  ),
                ],
              ),

              // Add/Remove Time Buttons
              if (!_isTimerRunning) ...[
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTimeAdjustButton('-1 min', -60),
                    const SizedBox(width: 8),
                    _buildTimeAdjustButton('+1 min', 60),
                  ],
                ),
              ],

              const SizedBox(height: 10), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickTimeButton(String label, int seconds) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          _seconds = seconds;
          _initialSeconds = seconds;
          _isTimerRunning = false;
        });
        _showSuccessSnackbar('Timer set to $label');
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        side: BorderSide(color: Colors.grey[400]!),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback? onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          style: IconButton.styleFrom(
            backgroundColor: color.withOpacity(0.1),
            foregroundColor: color,
            disabledForegroundColor: Colors.grey.withOpacity(0.5),
            padding: const EdgeInsets.all(12),
          ),
          iconSize: 28,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: onPressed == null ? Colors.grey : color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTimeAdjustButton(String label, int secondsToAdd) {
    return OutlinedButton(
      onPressed: () => _addTime(secondsToAdd),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        side: BorderSide(color: Colors.grey[400]!),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Color _getProgressColor(double progress) {
    if (progress < 0.5) return Colors.green;
    if (progress < 0.75) return Colors.orange;
    return Colors.red;
  }
}
