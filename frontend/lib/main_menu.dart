import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/game/scenario/presentation/nervous_bar.dart';
import 'package:mindscape/game/screen/lose_screen.dart';
import 'package:mindscape/game/screen/win_screen.dart';
import 'package:mindscape/game/ui/timer_display.dart';
import 'package:mindscape/styles/button_styles.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold (
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          spacing: 50,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Mindscape", 
              style: TextStyle(
                color: Colors.white,
                fontSize: screenHeight * 0.15,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              width: screenWidth * 0.3,
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    style: primaryButtonStyle,
                    child: const Text("Play"),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => GameWidget(
                          game: MainGame(),
                          overlayBuilderMap: {
                            "NervousBar": (context, MainGame game) => NervousBar(nervousValue: game.nervousValue),
                            "TimerDisplay": (context, MainGame game) => TimerDisplay(timeSecond: game.currentScenario.timerNotifier),
                            "LoseScreen": (context, MainGame game) => LoseScreen(score: game.score, game: game),
                            "WinScreen": (context, MainGame game) => WinScreen(game: game),
                          },
                        )),
                      );
                    }
                  ),
                  ElevatedButton(
                    style: primaryButtonStyle,
                    child: const Text("Options"),
                    onPressed: () {}
                  ),
                  ElevatedButton(
                    style: primaryButtonStyle,
                    child: const Text("Credits"),
                    onPressed: () {}
                  ),
                  ElevatedButton(
                    style: primaryButtonStyle,
                    child: const Text("Quit"),
                    onPressed: () {}
                  ),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
