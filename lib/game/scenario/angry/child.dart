import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/game/scenario/angry/item.dart';

enum State { 
  loseIpad, 
  loseBowl, 
  loseVase, 
  enterPaper, 
  enterDoll, 
  enterPillow, 
  idle1, 
  idle2, 
  idle3, 
  win,
}

class Child extends SpriteAnimationGroupComponent<State> with HasGameReference<MainGame>, CollisionCallbacks {
  late final SpriteAnimation loseIpad;
  late final SpriteAnimation loseBowl;
  late final SpriteAnimation loseVase;
  late final SpriteAnimation idle1;
  late final SpriteAnimation idle2; 
  late final SpriteAnimation idle3;
  late final SpriteAnimation enterPaper;
  late final SpriteAnimation enterDoll;
  late final SpriteAnimation enterPillow;
  late final SpriteAnimation win;

  Child() : super(
    anchor: Anchor.center,
    size: Vector2(1440, 810)
  );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    position = Vector2(-game.worldSize.x * 0.25, game.worldSize.y * 0.2);

    await add(RectangleHitbox(
      isSolid: true,
      // anchor: Anchor.center,
      position: Vector2(game.worldSize.x * 0.55, 0),
      size: Vector2(300, 700)
      )
    );
    await prepareAnimations();
    current = State.idle1;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Item) {
      Item item = other;
      if (item.safeToBreak) {
        print("YESSSSSSSSSSSs");
      } else {
        print("NOOOOOOOOO");
      }

      other.insideChildCollision = true;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other is Item) {
      print("outside");
      other.insideChildCollision = false;
    }
  }

  Future<void> prepareAnimations() async {
    idle1 = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_3/idle_1.png"), 
      SpriteAnimationData.sequenced(
        amount: 10, 
        stepTime: .1, 
        loop: true,
        textureSize: Vector2(1280, 720),
        amountPerRow: 4,
      )
    );
    idle2 = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_3/idle_2.png"), 
      SpriteAnimationData.sequenced(
        amount: 16, 
        stepTime: .1, 
        loop: true,
        textureSize: Vector2(1280, 720),
        amountPerRow: 4,
      )
    );
    idle3 = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_3/idle_3.png"), 
      SpriteAnimationData.sequenced(
        amount: 20, 
        stepTime: .1, 
        loop: true,
        textureSize: Vector2(1280, 720),
        amountPerRow: 5,
      )
    );
    loseBowl = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_3/lose_bowl.png"), 
      SpriteAnimationData.sequenced(
        amount: 23, 
        stepTime: .1, 
        loop: false,
        textureSize: Vector2(1280, 720),
        amountPerRow: 5,
      )
    );
    loseIpad = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_3/lose_ipad.png"), 
      SpriteAnimationData.sequenced(
        amount: 21, 
        stepTime: .1, 
        loop: false,
        textureSize: Vector2(1280, 720),
        amountPerRow: 5,
      )
    );
    loseVase = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_3/lose_vase.png"), 
      SpriteAnimationData.sequenced(
        amount: 23, 
        stepTime: .1, 
        loop: false,
        textureSize: Vector2(1280, 720),
        amountPerRow: 5,
      )
    );
    enterDoll = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_3/enter_doll.png"), 
      SpriteAnimationData.sequenced(
        amount: 10, 
        stepTime: .1, 
        loop: false,
        textureSize: Vector2(1280, 720),
        amountPerRow: 4,
      )
    );
    enterPaper = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_3/enter_paper.png"), 
      SpriteAnimationData.sequenced(
        amount: 29, 
        stepTime: .1, 
        loop: false,
        textureSize: Vector2(1280, 720),
        amountPerRow: 6,
      )
    );
    enterPillow = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_3/enter_pillow.png"), 
      SpriteAnimationData.sequenced(
        amount: 10, 
        stepTime: .1, 
        loop: false,
        textureSize: Vector2(1280, 720),
        amountPerRow: 4,
      )
    );
    win = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_3/win.png"), 
      SpriteAnimationData.sequenced(
        amount: 43, 
        stepTime: .05, 
        loop: false,
        textureSize: Vector2(1280, 720),
        amountPerRow: 7,
      )
    );

    animations = {
      State.idle1: idle1,
      State.idle2: idle2,
      State.idle3: idle3,
      State.loseBowl: loseBowl,
      State.loseVase: loseVase,
      State.loseIpad: loseIpad,
      State.enterDoll: enterDoll,
      State.enterPaper: enterPaper,
      State.enterPillow: enterPillow,
      State.win: win,
    };
  }
}
