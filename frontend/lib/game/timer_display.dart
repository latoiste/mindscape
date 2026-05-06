import 'package:flutter/material.dart';

class TimerDisplay extends StatelessWidget {
  final ValueNotifier<double> timeSecond;
  final double durationSecond;
  
  TimerDisplay({super.key, required this.timeSecond}) : 
    durationSecond = timeSecond.value;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsetsGeometry.only(left: 20.0, top: 20.0),
        child: ValueListenableBuilder(
          valueListenable: timeSecond, 
          builder: (context, value, child) {
            return CircularProgressIndicator(
              value: value/durationSecond,
              backgroundColor: Colors.blue[50],
              color: Colors.blue[300],
              strokeWidth: 20.0,
            );
          },
        ),
      )
    );
  }
}