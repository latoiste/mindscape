import 'dart:async';

import 'package:flutter/material.dart';

class Countdown extends StatefulWidget {
  final int durationSeconds;
  final bool autoStart;
  final void Function() onTimeout;

  const Countdown({
    super.key, 
    required this.durationSeconds, 
    required this.onTimeout,
    this.autoStart = true});

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  Timer? timer;
  late int secondsRemaining;

  @override
  void initState() {
    super.initState();

    if (widget.autoStart) startTimer();
  }
  
  void startTimer() {
    secondsRemaining = widget.durationSeconds;

    timer = Timer.periodic(
      Duration(
        seconds: 1
      ), (timer) {
        setState(() {
          secondsRemaining--;
          if (secondsRemaining <= 0) {
            widget.onTimeout();
            timer.cancel();
          }
        });
      });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Text(
      "$secondsRemaining",
      style: TextStyle(
        fontSize: screenHeight * 0.35,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}