import 'package:flutter/material.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/styles/button_styles.dart';
import 'package:mindscape/styles/text_styles.dart';

class LoseScreen extends StatelessWidget {
  final int score;
  final MainGame game;

  const LoseScreen({super.key, required this.score, required this.game});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 194, 192),
      body: Center(
        child: Column(
          children: [
          Text(
            "Game Over",
            style: TextStyle(
              fontSize: screenHeight * 0.2,
              fontWeight: FontWeight.w900
            ),
          ),
          Text(
            "Score: $score",
            style: TextStyle(
              fontSize: screenHeight * 0.1,
              fontWeight: FontWeight.w700
            ),
          ),
          SizedBox(
            width: screenWidth * 0.2,
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  style: primaryButtonStyle,
                  child: Text(
                    "Play Again",
                    style: menuTextStyle,
                  ),
                  onPressed: () {
                    game.overlays.remove('LoseScreen');
                    game.countdownScreen();
                  }
                ),
                ElevatedButton(
                  style: primaryButtonStyle,
                  child: Text(
                    "Back to Main Menu",
                    style: menuTextStyle,
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }
                ),
              ],)
          ),]
        ),
      ),
    );
  }
}