import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/widgets.dart';
import 'package:mindscape/game/main_game.dart';

class Item extends SpriteComponent with HasGameReference<MainGame>, DragCallbacks {
  final String spritePath;
  final bool safeToBreak;
  final Vector2 originalPosition;
  final ValueNotifier<Item?> childItemNotifier;
  bool insideChildCollision = false;

  Item({
    required this.spritePath, 
    required this.safeToBreak, 
    required this.originalPosition,
    required this.childItemNotifier}) : 
    super(
      anchor: Anchor.center,
      size: Vector2(100, 150),
    );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    position = originalPosition.clone();

    sprite = await game.loadSprite(spritePath);

    add(RectangleHitbox(collisionType: CollisionType.passive, isSolid: true));
  }

  void onGivenToChild() {
    // TODO: make this async and await play animation
    print("item given");
    removeFromParent();
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);

    position += event.canvasDelta;
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