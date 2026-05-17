import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/widgets.dart';
import 'package:mindscape/game/main_game.dart';

class Word extends SpriteComponent with HasGameReference<MainGame>, DragCallbacks, CollisionCallbacks {
  final Vector2 originalPosition;
  final ValueNotifier<Word?> wordSnapNotifier;
  bool insidePaper = false;
  bool draggable = true;

  Word({required this.originalPosition, required this.wordSnapNotifier}) : super (
    anchor: Anchor.center,
    size: Vector2(60, 20),
  );
  
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    position = originalPosition.clone();

    sprite = await game.loadSprite('images.png');

    add(RectangleHitbox(collisionType: CollisionType.passive));
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);

    if (draggable) {
      position += event.canvasDelta;
    }
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);

    if (!draggable) return;

    if (insidePaper) {
      wordSnapNotifier.value = this;
      draggable = false;
      return;
    }
    position = originalPosition;
  }
}