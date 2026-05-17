import 'package:flutter/material.dart';
import 'package:mindscape/game/main_game.dart';
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
  int wordsSnapped;

  SadScenario({required super.timeSecond}) :
    wordAmount = 5,
    wordSnapNotifier = ValueNotifier(null),
    wordsSnapped = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    speechBubble = SpeechBubble(wordAmount: wordAmount, wordSnapNotifier: wordSnapNotifier);
    paper = Paper(wordAmount: wordAmount);

    wordSnapNotifier.addListener(onSnapWordToPaper);
    wordSnapNotifier.addListener(speechBubble.onWordMoved);

    add(paper);
    add(speechBubble);
  }

  void onSnapWordToPaper() {
    Word word = wordSnapNotifier.value!;
    paper.snapWord(word);
    print(word.position);
    wordsSnapped++;

    if (wordsSnapped >= wordAmount) {
      super.gameEnd.value = GameResult.win;
    }
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
    wordSnapNotifier.removeListener(onSnapWordToPaper);
    wordSnapNotifier.removeListener(speechBubble.onWordMoved);
    wordSnapNotifier.dispose();

    super.onRemove();
  }
}