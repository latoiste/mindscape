import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/main_game.dart';

abstract class Scenario extends PositionComponent with HasGameReference<MainGame> {
  // late final Sprite background;
  final double timeSecond;
  final ValueNotifier<double> timerNotifier;
  final ValueNotifier<GameResult> gameEnd;

  Scenario({required this.timeSecond}) : 
    timerNotifier = ValueNotifier(timeSecond),
    gameEnd = ValueNotifier(GameResult.ongoing);

  void onWin();
  void onLose();
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = game.size;

    game.overlays.add('TimerDisplay');
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (timerNotifier.value <= 0) {
      return;
    }
    timerNotifier.value = clampDouble(timerNotifier.value - dt, 0, timerNotifier.value);
    
    if (timerNotifier.value <= 0) {
      gameEnd.value = GameResult.lose;
    }
  }

  @override
  void onRemove() {
    // background.image.dispose();
    timerNotifier.dispose();
    gameEnd.dispose();
  }
}
