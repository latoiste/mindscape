import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/scenario/presentation/breathe_box.dart';
import 'package:mindscape/game/scenario/presentation/heart.dart';
import 'package:mindscape/game/scenario/presentation/nervous_bar.dart';
import 'package:mindscape/game/scenario/scenario.dart';

class PresentationScenario extends Scenario with TapCallbacks {
  late final Heart feather;
  late final BreatheBox breatheBox;
  late final NervousBar nervousBar;

  final ValueNotifier<double> nervousValue;

  PresentationScenario({required this.nervousValue});

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    nervousValue.value = 0;

    feather = Heart();
    breatheBox = BreatheBox(nervousValue: nervousValue);

    add(breatheBox);
    add(feather);
    game.overlays.add('NervousBar');
  }

  @override
  void onFail() {
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
    feather.pushPower = 400;
    print("onTapDown called");
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    feather.pushPower = 0;
    print("onTapUp called");
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    feather.pushPower = 0;
    print("onTapCancel called");
  }
}