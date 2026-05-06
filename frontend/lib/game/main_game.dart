import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/scenario/presentation/presentation_scenario.dart';
import 'package:mindscape/game/scenario/scenario.dart';

class MainGame extends FlameGame with HasCollisionDetection {
  late int score;
  int prevIndex = -1;

  // overlay builder maps dependencies
  late ValueNotifier<double> nervousValue;
  // ====================

  static const int scenarioAmount = 1;

  @override
  // ignore: overridden_fields
  bool debugMode = true;

  @override
  Future<void> onLoad() async {
    var scenario = getRandomScenario();
    switchScenario(newScreen: scenario);
  }

  void switchScenario({Scenario? oldScreen, required Scenario newScreen}) {
    if (oldScreen != null) remove(oldScreen);
    add(newScreen);
  }

  Scenario getRandomScenario() {
    var random = Random();
    var index = random.nextInt(scenarioAmount);

    if (prevIndex == index) index = (index + 1) % scenarioAmount;

    prevIndex = index;

    switch (index) {
      case 0:
      default: // ini biar bisa return non nullable
        nervousValue = ValueNotifier(0);
        // TODO: bikin timeSecond dynamic
        return PresentationScenario(nervousValue: nervousValue, timeSecond: 5);
    }
  }
}