import 'dart:async';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Timer? _timer;
  Duration _duration = Duration(minutes: 25);
  bool _isRunning = false;

  void _start() {
    setState(() {
      _isRunning = true;
      _timer = Timer.periodic(Duration(seconds: 1), _onTick);
    });
  }

  void _stop() {
    setState(() {
      _isRunning = false;
      _timer?.cancel();
      _timer = null;
    });
  }

  void _reset() {
    setState(() {
      _timer?.cancel();
      _timer = null;
      _isRunning = false;
      _duration = Duration(minutes: 25);
    });
  }

  void _onTick(Timer timer) {
    setState(() {
      if (_duration > Duration.zero) {
        _duration = _duration - Duration(seconds: 1);
      } else {
        _timer!.cancel();
        _timer = null;
        _isRunning = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String minutes = (_duration.inMinutes < 10)
        ? '0' + _duration.inMinutes.toString()
        : _duration.inMinutes.toString();
    String seconds = (_duration.inSeconds.remainder(60) < 10)
        ? '0' + _duration.inSeconds.remainder(60).toString()
        : _duration.inSeconds.remainder(60).toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$minutes:$seconds',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text('Start'),
                  onPressed: _isRunning ? null : _start,
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  child: Text('Stop'),
                  onPressed: _isRunning ? _stop : null,
                ),
                SizedBox(width: 30),
                ElevatedButton(
                  child: Text('Reset'),
                  onPressed: _reset,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
