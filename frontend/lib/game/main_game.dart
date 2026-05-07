import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/scenario/presentation/presentation_scenario.dart';
import 'package:mindscape/game/scenario/scenario.dart';

enum GameResult {
  ongoing,
  win,
  lose,
}

class MainGame extends FlameGame with HasCollisionDetection {
  int score = 0;
  int prevIndex = -1;
  late Scenario currentScenario;

  // overlay builder maps dependencies
  final ValueNotifier<double> nervousValue = ValueNotifier(0);
  // ====================

  static const int scenarioAmount = 1;

  @override
  // ignore: overridden_fields
  bool debugMode = true;

  @override
  Future<void> onLoad() async {
    startGame();
  }

  void startGame() {
    score = 0;

    currentScenario = getRandomScenario();
    switchScenario(newScreen: currentScenario);
    resumeEngine();
  }

  void gameOver() {
    remove(currentScenario);
    pauseEngine();
    overlays.add('GameOver');
  }

  void switchScenario({Scenario? oldScreen, required Scenario newScreen}) {
    if (oldScreen != null) {
      oldScreen.gameEnd.removeListener(onGameEnd);
      remove(oldScreen);
    }

    newScreen.gameEnd.addListener(onGameEnd);
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
        nervousValue.value = 0;
        // TODO: bikin timeSecond dynamic
        return PresentationScenario(nervousValue: nervousValue, timeSecond: 5);
    }
  }

  void onGameEnd() {
    overlays.clear();

    switch (currentScenario.gameEnd.value) {
      case GameResult.win:
        currentScenario.onWin();
        score++;
      case GameResult.lose:
        currentScenario.onLose();
        gameOver();
      case GameResult.ongoing:
        return;
    }
  }

  @override
  void onRemove() {
    overlays.clear();
    nervousValue.dispose();
    currentScenario.gameEnd.removeListener(onGameEnd);

    super.onRemove();
  }
}