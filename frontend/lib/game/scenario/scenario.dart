import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/main_game.dart';

abstract class Scenario extends PositionComponent with HasGameReference<MainGame> {
  late final Sprite background;
  // late final 
  final double timeSecond;
  final ValueNotifier<double> timerNotifier;

  Scenario({required this.timeSecond}) :
    timerNotifier = ValueNotifier(timeSecond);

  void onWin();
  void onFail();
  
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
      onFail();
    }
  }

  @override
  void onRemove() {
    // need to dispose everything
    background.image.dispose();
    timerNotifier.dispose();
  }
}
