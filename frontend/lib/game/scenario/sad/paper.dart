import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/game/scenario/sad/word.dart';

// ini active
class Paper extends SpriteComponent with HasGameReference<MainGame>, CollisionCallbacks {
  late final List<Vector2> snapLocations;
  final int wordAmount;
  int snapIndex = 0;
  
  Paper({required this.wordAmount}) : super (
    anchor: Anchor.center,
    size: Vector2(400, 200),
  );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    position = Vector2(game.size.x/2, game.size.y - size.y/2);

    snapLocations = generateSnapLocations(position);
    sprite = await game.loadSprite('paper.png');
    
    add(RectangleHitbox(isSolid: true));
  }

  List<Vector2> generateSnapLocations(Vector2 position) {
    List<Vector2> locations = [];
    for (int i = 0; i < wordAmount; i++) {
      Vector2 next = Vector2(position.x, position.y * (0.8 + (0.1 * i)));
      locations.add(next);
    }

    return locations;
  }

  // listener buat wordSnapNotifier
  void snapWord(Word word) {
    word.position = snapLocations[snapIndex];
    print("word snap to $word.position");
    snapIndex++;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Word) {
      print("inside paper");
      other.insidePaper = true;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
    
    if (other is Word) {
      print("exit paper");
      other.insidePaper = false;
    }
  }

}