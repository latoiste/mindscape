import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/game/scenario/presentation/heart.dart';

class BreatheBox extends SpriteComponent with HasGameReference<MainGame>, CollisionCallbacks {
  final ValueNotifier<double> nervousValue;
  double dtPassed = 0;
  bool heartInside = false;

  BreatheBox({required this.nervousValue}) : super(
    size: Vector2(275, 100),
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = Vector2(1 * game.size.x/2, game.size.y/2);
    // print(position);
    
    sprite = await game.loadSprite('images.png');

    add(RectangleHitbox());
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

    position.y = (0.3 * sin(dtPassed/90) + 0.5) * game.size.y;
    if (heartInside) {
      nervousValue.value = clampDouble(nervousValue.value + 0.25 * dt, 0, 1);
    } else {
      nervousValue.value = clampDouble(nervousValue.value - 0.5 * dt, 0, 1);
    }
  }
}