import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/scenario/presentation/presentation_scenario.dart';
import 'package:mindscape/game/scenario/scenario.dart';

class MainGame extends FlameGame with HasCollisionDetection {
  late int score;
  late int prevIndex;
  final ValueNotifier<double> nervousValue = ValueNotifier(0);
  // final String nervousBarIdentifier = 'NervousBar';

  static const int scenarioAmount = 3;

  @override
  // ignore: overridden_fields
  bool debugMode = true;

  @override
  Future<void> onLoad() async {
    // pick a random index
    // store the index for scenarios somewhere
    var scenario = getRandomScenario();
    switchScenario(newScreen: scenario);
  }

  void switchScenario({Scenario? oldScreen, required Scenario newScreen}) {
    if (oldScreen != null) remove(oldScreen);
    add(newScreen);
  }

  Scenario getRandomScenario({Scenario? prevScenario}) {
    return PresentationScenario(nervousValue: nervousValue);
    // var random = Random();
    // int index = random.nextInt(scenarioAmount);

    // if (prevIndex == index) index = (index + 1) % scenarioAmount;

    // prevIndex = index;


    // switch (index) {
    //   case 0:
    //     return PresentationScenario();
    //   case 1:
    //     return SadScenario();
    //   case 2:
    //   default:
    //     return AngryScenario();
    // }
  }
}