import 'package:flutter/material.dart';
import 'package:mindscape/components/countdown.dart';
import 'package:mindscape/game/main_game.dart';

class CountdownScreen extends StatelessWidget {
  final MainGame game;

  const CountdownScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 194, 192),
      body: Center(
        child: Column(
          children: [
            Text(
              "Ready?",
              style: TextStyle(
                fontSize: screenHeight * 0.2,
                fontWeight: FontWeight.w900,
              ),
            ),
            Countdown(
              durationSeconds: 3,
              onTimeout: () {
                game.overlays.remove('CountdownScreen');
                game.startScenario();
                },
              ),
            Text(
              game.currentScenario.splashText,
              style: TextStyle(
                fontSize: screenHeight * 0.1,
              ),
            ),  
          ],
        )
      ),
    );
  }
}