import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/main_game.dart';

abstract class Scenario extends PositionComponent with HasGameReference<MainGame> {
  late final SpriteComponent background;
  final double timeSecond;
  final String backgroundPath;
  final ValueNotifier<double> timerNotifier;
  final ValueNotifier<GameResult> gameEndNotifier;
  bool paused = false;

  Scenario({required this.timeSecond, required this.backgroundPath}) : 
    timerNotifier = ValueNotifier(timeSecond),
    gameEndNotifier = ValueNotifier(GameResult.ongoing);

  Future<void> onWin() async {
    paused = true;
  }

  Future<void> onLose() async {
    paused = true;
  }
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = Vector2(1920, 1080);
    anchor = Anchor.center;

    background = SpriteComponent()
      ..sprite = await game.loadSprite(backgroundPath)
      ..size = Vector2(1920, 1080)
      ..anchor = Anchor.center
      ..priority = -1;

    await game.world.add(background);
    game.overlays.add('TimerDisplay');
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (paused || timerNotifier.value <= 0) {
      return;
    }
    timerNotifier.value = clampDouble(timerNotifier.value - dt, 0, timerNotifier.value);
    
    if (timerNotifier.value <= 0) {
      onTimerEnd();
    }
  }

  void onTimerEnd() {
      gameEndNotifier.value = GameResult.lose;
  }

  @override
  void onRemove() {
    timerNotifier.dispose();
    gameEndNotifier.dispose();
  }
}
