import 'dart:async';

import 'package:flame/components.dart';
import 'package:mindscape/game/main_game.dart';

// ngegenerate word
class SpeechBubble extends SpriteComponent with HasGameReference<MainGame> {
  SpeechBubble() : super(
    anchor: Anchor.center,
    size: Vector2(300, 150), 
  );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    sprite = await game.loadSprite('speech_bubble.png');

    position = Vector2(game.size.x/2, size.y/2);
  }

  // listener buat wordIndex changed
  void spawnNewWord() {

  }
}