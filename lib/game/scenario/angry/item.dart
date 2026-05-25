import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/widgets.dart';
import 'package:mindscape/game/main_game.dart';

enum ItemType { bowl, ipad, vase, doll, pillow, paper }

class Item extends SpriteComponent with HasGameReference<MainGame>, DragCallbacks {
  final String spritePath;
  final bool safeToBreak;
  final Vector2 originalPosition;
  final ValueNotifier<Item?> childItemNotifier;
  late final ItemType type;
  bool insideChildCollision = false;

  Item({
    required this.type,
    required this.spritePath, 
    required this.safeToBreak, 
    required this.originalPosition,
    required this.childItemNotifier,
  }) : 
    super(
      anchor: Anchor.center,
      size: Vector2(250, 250),
    );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    position = originalPosition.clone();

    final image = game.images.fromCache(spritePath);
    
    sprite = Sprite(image);

    add(RectangleHitbox(collisionType: CollisionType.passive, isSolid: true));
  }

  void onGivenToChild() {
    print("item given");
    removeFromParent();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);

    position += event.localDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);

    if (insideChildCollision) {
      childItemNotifier.value = this;
      onGivenToChild();
    } else {
      position = originalPosition;
    }
  }
}