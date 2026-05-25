import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/game/scenario/sad/child.dart';
import 'package:mindscape/game/scenario/sad/paper.dart';
import 'package:mindscape/game/scenario/sad/speech_bubble.dart';
import 'package:mindscape/game/scenario/sad/word.dart';
import 'package:mindscape/game/scenario/scenario.dart';

class SadScenario extends Scenario {
  late final SpeechBubble speechBubble;
  late final Paper paper;
  late final Child child;
  // late final Word word;
  final int wordAmount;
  final ValueNotifier<Word?> wordSnapNotifier;
  int wordsSnapped;

  SadScenario({required super.timeSecond}) :
    wordAmount = 5,
    wordSnapNotifier = ValueNotifier(null),
    wordsSnapped = 0, 
    super(
      backgroundPath: "scenario_2/background.png"
    );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    super.paused = true;

    speechBubble = SpeechBubble(wordAmount: wordAmount, wordSnapNotifier: wordSnapNotifier);
    paper = Paper(wordAmount: wordAmount);
    child = Child();

    wordSnapNotifier.addListener(onSnapWordToPaper);
    wordSnapNotifier.addListener(speechBubble.onWordMoved);

    await game.world.add(child);

    add(
      TimerComponent(
        period: 2.5,
        removeOnFinish: true,
        onTick: loadMainGameplay,
      ),
    );
  }

  Future<void> loadMainGameplay() async {
    print("hai");
    super.paused = false;
    background.sprite = await game.loadSprite("scenario_2/background2.png");
    child.isVisible = false;

    await game.world.addAll([
      speechBubble,
      paper,
    ]);
  }

  void onSnapWordToPaper() {
    Word word = wordSnapNotifier.value!;
    paper.snapWord(word);
    print(word.position);
    wordsSnapped++;

    if (wordsSnapped >= wordAmount) {
      super.gameEndNotifier.value = GameResult.win;
    }
  }

  @override
  Future<void> onLose() async {
    super.onLose();
    child.changeAnimation("lose");
    await Future.delayed(Duration(seconds: 2, milliseconds: 500));
  }

  @override
  Future<void> onWin() async {
    super.onWin();
    child.changeAnimation("win");
    await Future.delayed(Duration(seconds: 2, milliseconds: 500));
  }

  @override
  Future<void> onGameEnd() async {
    background.sprite = await game.loadSprite("scenario_2/background.png");
    child.isVisible = true;
    
    paper.removeFromParent();
    speechBubble.removeFromParent();
  }

  @override
  void onRemove() {
    if (paper.parent != null) paper.removeFromParent();
    if (speechBubble.parent != null) speechBubble.removeFromParent();
    child.removeFromParent();

    wordSnapNotifier.removeListener(onSnapWordToPaper);
    wordSnapNotifier.removeListener(speechBubble.onWordMoved);
    wordSnapNotifier.dispose();

    super.onRemove();
  }
}