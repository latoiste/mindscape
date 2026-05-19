import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/game/scenario/angry/child.dart';
import 'package:mindscape/game/scenario/angry/item.dart';
import 'package:mindscape/game/scenario/scenario.dart';

class AngryScenario extends Scenario {
  final ValueNotifier<Item?> childItemNotifier;
  late final Child child;
  late List<Vector2> itemLocations;

  int safeItemsCount = 0;
  List<String> safeToBreakSprites = [
    'paper.png',
    'pillow.png',
  ];
  List<String> unsafeToBreakSprites = [
    'heart.png',
  ];

  AngryScenario({required super.timeSecond}):
  childItemNotifier = ValueNotifier(null);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    child = Child();
    itemLocations = generateSpawnLocations();
    spawnItems();

    childItemNotifier.addListener(onGiveItem);
  
    add(child);
  }

  List<Vector2> generateSpawnLocations() {
    final double x = game.size.x;
    final double y = game.size.y;

    return [
      Vector2(0.1 * x, 0.5 * y),
      Vector2(0.3 * x, 0.2 * y),
      Vector2(0.7 * x, 0.4 * y),
    ];
  }

  void spawnItems() {
    Random random = Random();
    safeToBreakSprites.shuffle();
    unsafeToBreakSprites.shuffle();

    for (int i = 0; i < itemLocations.length; i++) {
      bool safeToBreak = random.nextBool();
      String spritePath;

      if ((safeToBreak && safeToBreakSprites.isNotEmpty) || unsafeToBreakSprites.isEmpty) {
        safeItemsCount++;
        safeToBreak = true;
        spritePath = safeToBreakSprites.removeLast();
      } else {
        safeToBreak = false;
        spritePath = unsafeToBreakSprites.removeLast();
      }

      Item item = Item(
        originalPosition: itemLocations[i], 
        safeToBreak: safeToBreak, 
        spritePath: spritePath, 
        childItemNotifier: childItemNotifier
      );

      add(item);
    }
  }

  void onGiveItem() {
    Item item = childItemNotifier.value!;

    if (!item.safeToBreak) {
      super.gameEnd.value = GameResult.lose;
      return;
    }
    safeItemsCount--;
    
    if (safeItemsCount <= 0) {
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
    childItemNotifier.removeListener(onGiveItem);
    childItemNotifier.dispose();

    super.onRemove();
  }
}