import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart' hide State;
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
  Map<ItemType, String> safeToBreakSprites = {
    ItemType.doll: 'scenario_3/doll.png',
    ItemType.paper: 'scenario_3/paper.png',
    ItemType.pillow: 'scenario_3/pillow.png',
  };
  Map<ItemType, String> unsafeToBreakSprites = {
    ItemType.bowl :'scenario_3/bowl.png',
    ItemType.vase :'scenario_3/vase.png',
    ItemType.ipad :'scenario_3/ipad.png',
  };

  AngryScenario({required super.timeSecond}):
    childItemNotifier = ValueNotifier(null),
    super (
      backgroundPath: "scenario_3/background.png",
      splashText: "Drag the soft objects to the child"
    );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    child = Child(childItemNotifier: childItemNotifier);
    itemLocations = generateSpawnLocations();
    spawnItems();

    childItemNotifier.addListener(onGiveItem);
    childItemNotifier.addListener(child.onReceiveItem);
  
    await game.world.add(child);
  }

  @override
  Future<void> onLose() async {
    super.onLose();

    child.playLoseAnimation(childItemNotifier.value!);
    await Future.delayed(Duration(seconds: 3));
  }

  @override
  Future<void> onWin() async {
    super.onWin();

    child.changeAnimation(State.win);
    await Future.delayed(Duration(seconds: 2));
  } 
    
  @override
  void onGameEnd() {}

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
    ];
  }

  void spawnItems() {
    Random random = Random();

    for (int i = 0; i < itemLocations.length; i++) {
      bool safeToBreak = random.nextBool();
      String? spritePath;
      ItemType type;

      if ((safeToBreak && safeToBreakSprites.isNotEmpty) || unsafeToBreakSprites.isEmpty) {
        safeItemsCount++;
        safeToBreak = true;
        type = safeToBreakSprites.keys.last;
        spritePath = safeToBreakSprites.remove(type);
      } else {
        safeToBreak = false;
        type = unsafeToBreakSprites.keys.last;
        spritePath = unsafeToBreakSprites.remove(type);
      }

      Item item = Item(
        type: type,
        originalPosition: itemLocations[i], 
        safeToBreak: safeToBreak, 
        spritePath: spritePath!, 
        childItemNotifier: childItemNotifier
      );

      game.world.add(item);
      items.add(item);
    }
  }

  void onGiveItem() {
    if (gameEndNotifier.value != GameResult.ongoing) return;
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
    childItemNotifier.removeListener(child.onReceiveItem);
    childItemNotifier.dispose();

    super.onRemove();
  }
}