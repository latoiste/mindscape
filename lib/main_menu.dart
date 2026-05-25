import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/game/scenario/presentation/nervous_bar.dart';
import 'package:mindscape/game/screen/lose_screen.dart';
import 'package:mindscape/game/screen/win_screen.dart';
import 'package:mindscape/game/ui/timer_display.dart';
import 'package:mindscape/styles/text_styles.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold (
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/main_menu.png"),
            fit: BoxFit.contain,
          ),
        ),
        child: Column(
          spacing: screenHeight * 0.05,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/title.png",
              height: screenHeight * 0.25,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: screenWidth * 0.3,
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    child: Text(
                      "Play",
                      style: menuTextStyle,
                    ),
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
                    child: Text(
                      "Options",
                      style: menuTextStyle,
                    ),
                    onPressed: () {}
                  ),
                  ElevatedButton(
                    child: Text(
                      "Credits",
                      style: menuTextStyle,
                    ),
                    onPressed: () {}
                  ),
                  ElevatedButton(
                    child: Text(
                      "Quit",
                      style: menuTextStyle,
                    ),
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
