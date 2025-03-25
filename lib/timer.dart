

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
  TextEditingController _controller = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer(); 

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
    setState(() {
      _seconds = int.tryParse(_controller.text) ??
          30 * 60; // Reset to input time or 30 minutes
      _initialSeconds = _seconds; // Reset initial time for progress calculation
      _isTimerRunning = false;
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Time Up!'),
        content:
            const Text('Congratulations on completing your learning session!'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // Method to play the alarm sound
  void _playAlarm() async {
    try {
      await _audioPlayer.play(
          AssetSource('alarm_sound.wav')); 
    } catch (e) {
      debugPrint('Error playing alarm sound: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _seconds ~/ 60;
    final seconds = _seconds % 60;
    final progress = (_seconds / _initialSeconds);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Timer'),
        backgroundColor: const Color.fromARGB(255, 107, 107, 210),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter time in seconds',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 230, 100, 53)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _resetTimer,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 233, 202, 92),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Set Timer'),
            ),
            const SizedBox(height: 20),

            Text(
              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 107, 107, 210),
              ),
            ),
            const SizedBox(height: 20),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _isTimerRunning ? null : _startTimer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 131, 222, 134),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Start Timer'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: _isTimerRunning ? _pauseTimer : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 121, 166, 211),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Pause Timer'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _resetTimer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 233, 100, 90),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Reset Timer'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (_isTimerRunning)
                  LinearProgressIndicator(
                    value: progress,
                    color: const Color.fromARGB(255, 210, 135, 37),
                    backgroundColor: Colors.grey[300],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
