import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
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
  late final Vector2 worldSize;

  // overlay builder maps dependencies
  final ValueNotifier<double> nervousValue = ValueNotifier(0);
  // ====================

  static const int scenarioAmount = 1;

  @override
  // ignore: overridden_fields
  bool debugMode = true;

  @override
  Future<void> onLoad() async {
    camera = CameraComponent.withFixedResolution(
      width: 1920,
      height: 1080,
    );

    worldSize = camera.visibleWorldRect.size.toVector2();
    await preloadImages();

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
    currentScenario.removeFromParent();
    overlays.add('LoseScreen');
  }

  void switchScenario({Scenario? oldScenario, required Scenario newScenario}) {
    if (oldScenario != null) {
      oldScenario.gameEndNotifier.removeListener(onGameEnd);
      oldScenario.removeFromParent();
    }

    newScenario.gameEndNotifier.addListener(onGameEnd);
    world.add(newScenario);
  }

  Scenario getRandomScenario() {
    var random = Random();
    var index = random.nextInt(scenarioAmount);

    if (prevIndex == index) index = (index + 1) % scenarioAmount;

    prevIndex = index;

    switch (index) {
      // case 0:
      //   return SadScenario(timeSecond: 50, backgroundPath: "");
      case 0:
      default: // ini biar bisa return non nullable
        nervousValue.value = 0;
        // TODO: bikin timeSecond dynamic
        return PresentationScenario(nervousValue: nervousValue, timeSecond: 10);
    }
  }

  Future<void> preloadImages() async{
    await images.loadAll([
      "scenario_1/breathing1.png",
      "scenario_1/breathing2.png",
      "scenario_1/idle.png",
      "scenario_1/win.png",
      "scenario_1/lose.png",
    ]);
  }

  void onGameEnd() async {
    overlays.clear();

    switch (currentScenario.gameEndNotifier.value) {
      case GameResult.win:
        await currentScenario.onWin();
        win();
        break;
      case GameResult.lose:
        await currentScenario.onLose();
        gameOver();
        break;
      case GameResult.ongoing:
        return;
    }
  }

  @override
  void onRemove() {
    overlays.clear();
    nervousValue.dispose();
    currentScenario.gameEndNotifier.removeListener(onGameEnd);

    super.onRemove();
  }
}