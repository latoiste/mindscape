import 'dart:ui';

import 'package:flame/components.dart';
import 'package:mindscape/game/main_game.dart';

abstract class Scenario extends PositionComponent with HasGameReference<MainGame> {
  late final Sprite background;
  // late final 
  double timeSecond;

  Scenario({required this.timeSecond});

  void onWin();
  void onFail();
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = game.size;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // if (timeSecond <= 0) {
    //   return;
    // }
    timeSecond = clampDouble(timeSecond - dt, 0, timeSecond);
    
    if (timeSecond <= 0) {
      onFail();
    }
  }

  @override
  void onRemove() {
    // need to dispose everything
    background.image.dispose();
  }
}
