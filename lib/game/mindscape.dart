import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/game/scenario/presentation/nervous_bar.dart';
import 'package:mindscape/game/screen/lose_screen.dart';
import 'package:mindscape/game/screen/win_screen.dart';
import 'package:mindscape/game/ui/timer_display.dart';

class Mindscape extends StatelessWidget {
  const Mindscape({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: MainGame(),
      overlayBuilderMap: {
        "NervousBar": (context, MainGame game) => NervousBar(nervousValue: game.nervousValue),
        "TimerDisplay": (context, MainGame game) => TimerDisplay(timeSecond: game.currentScenario.timerNotifier),
        "LoseScreen": (context, MainGame game) => LoseScreen(score: game.score, game: game),
        "WinScreen": (context, MainGame game) => WinScreen(game: game),
      },
    );
  }
}