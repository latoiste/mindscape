import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/scenario/sad/paper.dart';
import 'package:mindscape/game/scenario/sad/speech_bubble.dart';
import 'package:mindscape/game/scenario/sad/word.dart';
import 'package:mindscape/game/scenario/scenario.dart';

class SadScenario extends Scenario {
  late final SpeechBubble speechBubble;
  late final Paper paper;
  // late final Word word;
  final int wordAmount;
  final ValueNotifier<Word?> wordSnapNotifier;

  SadScenario({required super.timeSecond}) :
    wordAmount = 5,
    wordSnapNotifier = ValueNotifier(null);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    speechBubble = SpeechBubble();
    paper = Paper(wordAmount: wordAmount);
    // word = Word(originalPosition: Vector2(game.size.x/2, game.size.y/2), wordSnapNotifier: wordSnapNotifier);
    

    wordSnapNotifier.addListener(snapWordToPaper);
    wordSnapNotifier.addListener(speechBubble.spawnNewWord);

    add(speechBubble);
    add(paper);
    double x = 100;
    double y = 100;
    for (int i = 0; i < wordAmount; i++) {
      Word word = Word(originalPosition: Vector2(x, y + (50 * i)), wordSnapNotifier: wordSnapNotifier);
      add(word);
    }
  }

  void snapWordToPaper() {
    Word word = wordSnapNotifier.value!;
    paper.snapWord(word);
  }

  @override
  void onLose() {
    // TODO: implement onLose
  }

  @override
  void onWin() {
    // TODO: implement onWin
  }

  @override
  void onRemove() {
    wordSnapNotifier.removeListener(snapWordToPaper);
    wordSnapNotifier.removeListener(speechBubble.spawnNewWord);
    wordSnapNotifier.dispose();

    super.onRemove();
  }
}