import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:mindscape/game/main_game.dart';

class Heart extends SpriteComponent with HasGameReference<MainGame> {
  static const gravity = 300.0;
  int pushPower = 0;
  Vector2 velocity = Vector2.zero();

  Heart() : super (
    anchor: Anchor.center,
    size: Vector2(300, 200),
  );

  @override
  Future<void> onLoad() async{
    await super.onLoad();

    sprite = await game.loadSprite('heart.png');

    position = game.camera.visibleWorldRect.center.toVector2();

    add(RectangleHitbox(collisionType: CollisionType.passive, size: Vector2(275, height)));
  }

  @override
  void update(double dt) {
    super.update(dt);

    velocity.y = clampDouble(velocity.y + (gravity - pushPower) * dt, -300, 250);
    position.y = clampDouble(position.y + velocity.y * dt, -game.worldSize.y/2 + size.y/2, game.worldSize.y/2 - size.y/2);
  }
}