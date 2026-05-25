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
  final random = Random();
  List<Word> words = [];
  
  SpeechBubble({required this.wordAmount, required this.wordSnapNotifier}) : 
  currentWordsNotifier = ValueNotifier(-1),
  wordSpawned = 0,
  super(
    anchor: Anchor.center,
    size: Vector2(1920, 1080), 
  );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    
    // position = Vector2(game.size.x/2, size.y/2);
    currentWordsNotifier.addListener(trySpawnNewWord);
    sprite = Sprite(game.images.fromCache("scenario_2/bubble.png"));

    currentWordsNotifier.value = 0;
  }

  // listener buat wordIndex changed
  void trySpawnNewWord() {
    if (currentWordsNotifier.value >= 2 || wordSpawned >= wordAmount) return;

    final randomPos = getRandomLocation();
    Word word = Word(originalPosition: randomPos, wordSnapNotifier: wordSnapNotifier);

    game.world.add(word);
    words.add(word);

    currentWordsNotifier.value++;
    wordSpawned++;
  }

  void onWordMoved() {
    currentWordsNotifier.value--;
  }

  Vector2 getRandomLocation() {
    final x = (random.nextDouble() - 0.5) * game.worldSize.x;

    final min = -game.worldSize.y/2;
    final max = -game.worldSize.y/2 * 0.8;

    final y = min + random.nextDouble() * (max - min);

    return Vector2(x, y); 
  }

  @override
  void onRemove() {
    currentWordsNotifier.removeListener(trySpawnNewWord);
    currentWordsNotifier.dispose();
    
    for (Word word in words) {
      if (word.parent != null) word.removeFromParent();
    }

    super.onRemove();
  }
}