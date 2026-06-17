import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/api/score.dart';
import 'package:mindscape/game/scenario/angry/angry_scenario.dart';
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
  late Scenario? oldScenario;
  late Scenario currentScenario;
  late final Vector2 worldSize;

  Future<void>? imagePreloadOp;

  // overlay builder maps dependencies
  final ValueNotifier<double> nervousValue = ValueNotifier(0);
  // ====================

  static const int scenarioAmount = 3;

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
    gameEntrypoint();

    imagePreloadOp = preloadImages();
  }

  void gameEntrypoint() {
    score = 0;
    oldScenario = null;
    pauseEngine();

    countdownScreen();
  }

  void countdownScreen() async {
    currentScenario = getRandomScenario();
    overlays.add('CountdownScreen');
    await imagePreloadOp;
  }

  void startScenario() {
    // not first scenario
    if (oldScenario != null) {
      switchScenario(oldScenario: oldScenario, newScenario: currentScenario);
    } 
    // first scenario
    else {
      switchScenario(newScenario: currentScenario);
    }
    resumeEngine();
  }

  void win() {
    score++;
    pauseEngine();

    Scenario newScenario = getRandomScenario();
    oldScenario = currentScenario;
    currentScenario = newScenario;

    overlays.add('CountdownScreen');
  }

  void gameOver() {
    pauseEngine();

    currentScenario.gameEndNotifier.removeListener(onGameEnd);
    currentScenario.removeFromParent();
    overlays.add('LoseScreen');

    updateHighscore(score);
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
      case 0:
        return AngryScenario(timeSecond: 10);
      case 1:
        return SadScenario(timeSecond: 10);
      case 2:
      default: // ini biar bisa return non nullable
        nervousValue.value = 0;
        return PresentationScenario(nervousValue: nervousValue, timeSecond: 10);
    }
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

  Future<void> preloadImages() async{
    await images.loadAll([
      "scenario_1/breathing1.png",
      "scenario_1/breathing2.png",
      "scenario_1/idle.png",
      "scenario_1/win.png",
      "scenario_1/lose.png",

      "scenario_2/background.png",
      "scenario_2/background2.png",
      "scenario_2/bubble.png",
      "scenario_2/win.png",
      "scenario_2/lose.png",
      "scenario_2/idle.png",

      "scenario_3/background.png",
      "scenario_3/enter_doll.png",
      "scenario_3/enter_paper.png",
      "scenario_3/enter_pillow.png",
      "scenario_3/idle_1.png",
      "scenario_3/idle_2.png",
      "scenario_3/idle_3.png",
      "scenario_3/lose_bowl.png",
      "scenario_3/lose_ipad.png",
      "scenario_3/lose_vase.png",
      "scenario_3/win.png",
      "scenario_3/bowl.png",
      "scenario_3/vase.png",
      "scenario_3/ipad.png",
      "scenario_3/doll.png",
      "scenario_3/paper.png",
      "scenario_3/pillow.png",
    ]);
  }
}