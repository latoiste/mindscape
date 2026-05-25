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
  List<Item> items = [];

  int safeItemsCount = 0;
  List<String> safeToBreakSprites = [
    'scenario_3/doll.png',
    'scenario_3/paper.png',
    'scenario_3/pillow.png',
  ];
  List<String> unsafeToBreakSprites = [
    'scenario_3/bowl.png',
    'scenario_3/vase.png',
    'scenario_3/ipad.png',
  ];

  AngryScenario({required super.timeSecond}):
    childItemNotifier = ValueNotifier(null),
    super (
      backgroundPath: "scenario_3/background.png",
    );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    child = Child();
    itemLocations = generateSpawnLocations();
    spawnItems();

    childItemNotifier.addListener(onGiveItem);
  
    await game.world.add(child);
  }

  @override
  Future<void> onLose() async {
    super.onLose();
    // TODO: implement onLose
  }

  @override
  Future<void> onWin() async {
    super.onWin();
    // TODO: implement onWin
  } 
    
  @override
  void onGameEnd() {
    // TODO: implement onGameEnd
  }

  List<Vector2> generateSpawnLocations() {
    final double x = game.worldSize.x;
    final double y = game.worldSize.y;

    return [
      Vector2(0.35 * x, 0.15 * y), //doll
      Vector2(0.4 * x, 0.35 * y), //pillow
      Vector2(0.2 * x, 0.15 * y), //bowl
      Vector2(-0.18 * x, 0.15 * y), //ipad
      Vector2(-0.35 * x, 0.30 * y), //vase
      Vector2(-0.45 * x, 0.35 * y), //paper
      // Vector2() //bowl
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

      game.world.add(item);
      items.add(item);
    }
  }

  void onGiveItem() {
    Item item = childItemNotifier.value!;

    if (!item.safeToBreak) {
      super.gameEndNotifier.value = GameResult.lose;
      return;
    }
    safeItemsCount--;
    
    if (safeItemsCount <= 0) {
      super.gameEndNotifier.value = GameResult.win;
    }
  }

  @override
  void onRemove() {
    child.removeFromParent();

    for (Item item in items) {
      if (item.parent != null) item.removeFromParent();
    }

    childItemNotifier.removeListener(onGiveItem);
    childItemNotifier.dispose();

    super.onRemove();
  }
}