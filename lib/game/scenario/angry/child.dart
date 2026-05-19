import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/game/scenario/angry/item.dart';

class Child extends SpriteComponent with HasGameReference<MainGame>, CollisionCallbacks {
  Child() : super(
    anchor: Anchor.center,
    size: Vector2(60, 100)
  );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    position = Vector2(game.size.x/2, game.size.y - size.y/2);

    sprite = await game.loadSprite('boy.png');

    add(RectangleHitbox(isSolid: true));
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Item) {
      Item item = other;
      if (item.safeToBreak) {
        print("YESSSSSSSSSSSs");
      } else {
        print("NOOOOOOOOO");
      }

      other.insideChildCollision = true;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other is Item) {
      print("outside");
      other.insideChildCollision = false;
    }
  }
}
