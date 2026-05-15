import 'package:flutter/material.dart';
import 'package:mindscape/components/countdown.dart';
import 'package:mindscape/game/main_game.dart';

class WinScreen extends StatelessWidget {
  final MainGame game;

  const WinScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
          Text(
            "You Win",
            style: TextStyle(
              fontSize: screenHeight * 0.2
            ),
          ),
          Countdown(
            durationSeconds: 3,
            onTimeout: () {
              game.overlays.remove('WinScreen');
              game.nextScenario();
              },
            ),
          ],
        )
      ),
    );
  }
}