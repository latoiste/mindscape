import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/main_game.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          spacing: 50,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Mindscape", 
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            FloatingActionButton.extended(
              label: const Text("Play"),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => GameWidget(game: MainGame())),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
