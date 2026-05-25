import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/game/scenario/sad/word.dart';

// ini active
class Paper extends PositionComponent with HasGameReference<MainGame>, CollisionCallbacks {
  final int wordAmount;
  
  Paper({required this.wordAmount}) : super (
    anchor: Anchor.center,
    size: Vector2(1100, 500),
  );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    position = Vector2(-80, game.worldSize.y/8);

    add(RectangleHitbox(isSolid: true));
  }

  // listener buat wordSnapNotifier
  void snapWord(Word word) {
    // word.position = snapLocations[snapIndex];
    word.removeFromParent();
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