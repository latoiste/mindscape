import 'package:flutter/material.dart';

class NervousBar extends StatelessWidget {
  final ValueNotifier<double> nervousValue;

  const NervousBar({super.key, required this.nervousValue});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 40.0),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          // spacing: -1,
          children: [
            // Text("data"),
            SizedBox(
              height: screenHeight * 0.8,
              width: screenWidth * 0.025,
              child: RotatedBox(
                quarterTurns: -1,
                child: ValueListenableBuilder<double>(
                  valueListenable: nervousValue,
                  builder: (context, value, child) {
                    return LinearProgressIndicator(
                      value: value,
                      minHeight: 90,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      backgroundColor: Colors.pink[50],
                      color: Colors.pink[300],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
