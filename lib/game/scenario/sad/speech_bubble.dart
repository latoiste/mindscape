import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/game/scenario/sad/word.dart';

// ngegenerate word
class SpeechBubble extends SpriteComponent with HasGameReference<MainGame> {
  final int wordAmount;
  final ValueNotifier<int> currentWordsNotifier;
  final ValueNotifier<Word?> wordSnapNotifier;
  int wordSpawned;
  
  SpeechBubble({required this.wordAmount, required this.wordSnapNotifier}) : 
  currentWordsNotifier = ValueNotifier(-1),
  wordSpawned = 0,
  super(
    anchor: Anchor.center,
    size: Vector2(300, 150), 
  );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    
    position = Vector2(game.size.x/2, size.y/2);
    currentWordsNotifier.addListener(trySpawnNewWord);

    sprite = await game.loadSprite('speech_bubble.png');

    currentWordsNotifier.value = 0;
  }

  // listener buat wordIndex changed
  void trySpawnNewWord() {
    if (currentWordsNotifier.value >= 2 || wordSpawned >= wordAmount) return;

    final randomPos = getRandomLocation();
    Word word = Word(originalPosition: randomPos, wordSnapNotifier: wordSnapNotifier);

    parent!.add(word);
    currentWordsNotifier.value++;
    wordSpawned++;
  }

  void onWordMoved() {
    currentWordsNotifier.value--;
  }

  Vector2 getRandomLocation() {
    final rect = toAbsoluteRect();

    final x = rect.left + Random().nextDouble() * (rect.right - rect.left);
    final y = rect.top + Random().nextDouble() * (rect.bottom - rect.top);

    return Vector2(x, y); 
  }

  @override
  void onRemove() {
    currentWordsNotifier.removeListener(trySpawnNewWord);
    currentWordsNotifier.dispose();

    super.onRemove();
  }
}