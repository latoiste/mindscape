import 'dart:math';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/scenario/presentation/presentation_scenario.dart';
import 'package:mindscape/game/scenario/sad/sad_scenario.dart';
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

  static const int scenarioAmount = 2;

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
    switchScenario(newScenario: currentScenario);
    resumeEngine();
  }

  void win() {
    score++;
    pauseEngine();
    overlays.add('WinScreen');
  }

  void nextScenario() {
    Scenario newScenario = getRandomScenario();
    switchScenario(oldScenario: currentScenario, newScenario: newScenario);
    currentScenario = newScenario;

    resumeEngine();
  }

  void gameOver() {
    pauseEngine();
    remove(currentScenario);
    overlays.add('LoseScreen');
  }

  void switchScenario({Scenario? oldScenario, required Scenario newScenario}) {
    if (oldScenario != null) {
      oldScenario.gameEnd.removeListener(onGameEnd);
      remove(oldScenario);
    }

    newScenario.gameEnd.addListener(onGameEnd);
    add(newScenario);
  }

  Scenario getRandomScenario() {
    var random = Random();
    var index = random.nextInt(scenarioAmount);

    if (prevIndex == index) index = (index + 1) % scenarioAmount;

    prevIndex = index;

    switch (index) {
      case 0:
        return SadScenario(timeSecond: 50);
      case 1:
      default: // ini biar bisa return non nullable
        nervousValue.value = 0;
        // TODO: bikin timeSecond dynamic
        return PresentationScenario(nervousValue: nervousValue, timeSecond: 50);
    }
  }

  void onGameEnd() {
    overlays.clear();

    switch (currentScenario.gameEnd.value) {
      case GameResult.win:
        currentScenario.onWin();
        win();
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