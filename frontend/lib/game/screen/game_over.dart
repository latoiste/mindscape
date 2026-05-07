import 'package:flutter/material.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/styles/button_styles.dart';

class GameOverScreen extends StatelessWidget {
  final int score;
  final MainGame game;

  const GameOverScreen({super.key, required this.score, required this.game});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          children: [
          Text(
            "Game Over",
            style: TextStyle(
              fontSize: screenHeight * 0.2
            ),
          ),
          Text(
            "Score: $score",
            style: TextStyle(
              fontSize: screenHeight * 0.1
            ),
          ),
          ElevatedButton(
            style: primaryButtonStyle,
            child: const Text("Play Again"),
            onPressed: () {
              game.overlays.remove('GameOver');
              game.startGame();
            }
          ),
          ElevatedButton(
            style: primaryButtonStyle,
            child: const Text("Back to Main Menu"),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            }
          ),],
        ),
      ),
    );
  }
}