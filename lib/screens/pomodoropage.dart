import 'package:flutter/material.dart';

class PomodoroPage extends StatefulWidget {
  @override
  _PomodoroPageState createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  int _minutes = 25;
  int _seconds = 0;
  bool _isRunning = false;
  late Duration _timerDuration;
  late DateTime _endTime;

  @override
  void initState() {
    super.initState();
    _timerDuration = Duration(minutes: _minutes, seconds: _seconds);
    _endTime = DateTime.now().add(_timerDuration);
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
      _endTime = DateTime.now().add(_timerDuration);
    });
    _updateTimer();
  }

  void _pauseTimer() {
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    setState(() {
      _isRunning = false;
      _minutes = 25;
      _seconds = 0;
      _timerDuration = Duration(minutes: _minutes, seconds: _seconds);
      _endTime = DateTime.now().add(_timerDuration);
    });
  }

  void _updateTimer() {
    Future.delayed(Duration(seconds: 1), () {
      if (!_isRunning) return;
      setState(() {
        Duration remaining = _endTime.difference(DateTime.now());
        _minutes = remaining.inMinutes;
        _seconds = remaining.inSeconds % 60;
      });
      if (_minutes <= 0 && _seconds <= 0) {
        _isRunning = false; // Timer finished
      } else {
        _updateTimer();
      }
    });
  }

  String _formatTime(int time) {
    return time < 10 ? '0$time' : '$time';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${_formatTime(_minutes)}:${_formatTime(_seconds)}',
              style: TextStyle(fontSize: 60.0),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isRunning ? _pauseTimer : _startTimer,
                  child: Text(_isRunning ? 'Pause' : 'Start'),
                ),
                ElevatedButton(
                  onPressed: _resetTimer,
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
