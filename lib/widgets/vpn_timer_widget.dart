import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meme_vpn/utils/responsive.dart';

class CountDownTimer extends StatefulWidget {
  final dynamic startTimer;

  const CountDownTimer({super.key, required this.startTimer});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Duration _duration = Duration();
  Timer? _timer;

  _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _duration = Duration(seconds: _duration.inSeconds + 1);
      });
    });
  }

  _stopTimer() {
    setState(() {
      _timer?.cancel();
      _timer = null;
      _duration = Duration();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_timer == null || !widget.startTimer)
      widget.startTimer ? _startTimer() : _stopTimer();

    String twoDigit(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigit(_duration.inMinutes.remainder(60));
    final seconds = twoDigit(_duration.inSeconds.remainder(60));
    final hours = twoDigit(_duration.inHours.remainder(60));

    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Container(
        alignment: Alignment.center,
        height: ScreenUtils.screenHeight(context) / 13.5,
        width: ScreenUtils.screenWidth(context) - 30,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12)),
        child: Text('$hours: $minutes: $seconds',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }
}
