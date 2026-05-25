import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/game/scenario/presentation/breathe_box.dart';
import 'package:mindscape/game/scenario/presentation/child.dart';
import 'package:mindscape/game/scenario/presentation/heart.dart';
import 'package:mindscape/game/scenario/presentation/nervous_bar.dart';
import 'package:mindscape/game/scenario/scenario.dart';

class PresentationScenario extends Scenario with TapCallbacks {
  late final Heart heart;
  late final BreatheBox breatheBox;
  late final NervousBar nervousBar;
  late final Child child;
  bool isOnBreathing2 = false;

  final ValueNotifier<double> nervousValue;

  PresentationScenario({
    required super.timeSecond, 
    required this.nervousValue
  }) : super(
    backgroundPath: "scenario_1/background.png"
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    nervousValue.addListener(onNervousValueChanged);

    heart = Heart();
    breatheBox = BreatheBox(nervousValue: nervousValue);
    child = Child();

    await game.world.add(breatheBox);
    await game.world.add(heart);
    await game.world.add(child);
    game.overlays.add('NervousBar');
  }

  @override
  Future<void> onLose() async {
    super.onLose();

    child.changeAnimation("lose");
    await Future.delayed(Duration(seconds: 5));
  }

  @override
  Future<void> onWin() async {
    super.onWin();

    
    child.changeAnimation("win");
    await Future.delayed(Duration(seconds: 5));
  }
  
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    heart.pushPower = 600;
    print("onTapDown called");
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    heart.pushPower = 0;
    print("onTapUp called");
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    heart.pushPower = 0;
    print("onTapCancel called");
  }

  void onNervousValueChanged() {
    if (!isOnBreathing2 && nervousValue.value >= 0.50) {
      isOnBreathing2 = true;
      child.changeAnimation("breathing2");
    }

    if (nervousValue.value >= 1) {
      super.gameEndNotifier.value = GameResult.win;
    }
  }

  @override
  void onRemove() {
    breatheBox.removeFromParent();
    heart.removeFromParent();
    child.removeFromParent();

    nervousValue.removeListener(onNervousValueChanged);
    
    super.onRemove();
  }
}