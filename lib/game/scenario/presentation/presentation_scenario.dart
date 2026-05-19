import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/game/scenario/presentation/breathe_box.dart';
import 'package:mindscape/game/scenario/presentation/heart.dart';
import 'package:mindscape/game/scenario/presentation/nervous_bar.dart';
import 'package:mindscape/game/scenario/scenario.dart';

class PresentationScenario extends Scenario with TapCallbacks {
  late final Heart heart;
  late final BreatheBox breatheBox;
  late final NervousBar nervousBar;

  final ValueNotifier<double> nervousValue;

  PresentationScenario({required super.timeSecond, required this.nervousValue});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    nervousValue.addListener(onNervousValueChanged);

    heart = Heart();
    breatheBox = BreatheBox(nervousValue: nervousValue);

    add(breatheBox);
    add(heart);
    game.overlays.add('NervousBar');
  }

  @override
  void onLose() {
    // TODO: implement onFail
    // Play losing animaton??
  }

  @override
  void onWin() {
    // TODO: implement onWin
    // Play winning animation
  }
  
  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    heart.pushPower = 400;
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
    if (nervousValue.value >= 1) {
      super.gameEndNotifier.value = GameResult.win;
    }
  }

  @override
  void onRemove() {
    remove(breatheBox);
    remove(heart);

    nervousValue.removeListener(onNervousValueChanged);
    
    super.onRemove();
  }
}