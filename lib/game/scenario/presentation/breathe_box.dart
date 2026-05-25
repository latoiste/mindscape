import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/game/scenario/presentation/heart.dart';

class BreatheBox extends SpriteComponent with HasGameReference<MainGame>, CollisionCallbacks {
  final ValueNotifier<double> nervousValue;
  double dtPassed = 0;
  bool heartInside = false;

  BreatheBox({required this.nervousValue}) : super(
    size: Vector2(800, 350),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    position = game.camera.visibleWorldRect.center.toVector2();
    
    sprite = await game.loadSprite('scenario_1/breathe_box.png');

    setOpacity(0.5);

    add(RectangleHitbox(isSolid: true));
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
  
    if (other is Heart) {
      heartInside = true;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    if (other is Heart) {
      heartInside = false;
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    double x = dt * 100;
    dtPassed += x;

    position.y = (0.25 * sin(dtPassed/75)) * game.worldSize.y;
    if (heartInside) {
      nervousValue.value = clampDouble(nervousValue.value + 0.20 * dt, 0, 1);
    } else {
      nervousValue.value = clampDouble(nervousValue.value - 0.45 * dt, 0, 1);
    }
  }
}