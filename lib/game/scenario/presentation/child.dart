import 'dart:async';

import 'package:flame/components.dart';
import 'package:mindscape/game/main_game.dart';

enum State { idle, breathing1, breathing2, win, lose }

class Child extends SpriteAnimationGroupComponent<State> with HasGameReference<MainGame> {
  late final SpriteAnimation idle;
  late final SpriteAnimation breathing1;
  late final SpriteAnimation breathing2;
  late final SpriteAnimation win;
  late final SpriteAnimation lose;
  late final SpriteAnimation winComp;

  Child() : super (
    size: Vector2(1440, 810),
    anchor: Anchor.center,
  );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    position = Vector2(-game.worldSize.x/3, game.worldSize.y/5);

    await prepareAnimations();
    current = State.breathing1;
  }

  void changeAnimation(String animationName) {
    print("animation changed");
    switch (animationName) {
      case "idle":
        current = State.idle;
        break;
      case "breathing1":
        current = State.breathing1;
        break;
      case "breathing2":
        current = State.breathing2;
        break;
      case "lose":
        current = State.lose;
        break;
      case "win":
        current = State.win;
        break;
      default:
    }
  }

  Future<void> prepareAnimations() async {
    idle = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_1/idle.png"), 
      SpriteAnimationData.sequenced(
        amount: 20, 
        stepTime: .1, 
        loop: true,
        textureSize: Vector2(1280, 720),
        amountPerRow: 5,
      )
    );
    breathing1 = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_1/breathing1.png"), 
      SpriteAnimationData.sequenced(
        amount: 20, 
        stepTime: .1, 
        loop: true,
        textureSize: Vector2(1280, 720),
        amountPerRow: 5,
      )
    );
    breathing2 = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_1/breathing2.png"), 
      SpriteAnimationData.sequenced(
        amount: 20, 
        stepTime: .1, 
        loop: true,
        textureSize: Vector2(1280, 720),
        amountPerRow: 5,
      )
    );
    lose = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_1/lose.png"), 
      SpriteAnimationData.sequenced(
        amount: 30, 
        stepTime: .1, 
        loop: false,
        textureSize: Vector2(1280, 720),
        amountPerRow: 6,
      )
    );
    win = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_1/win.png"), 
      SpriteAnimationData.sequenced(
        amount: 50, 
        stepTime: .1, 
        loop: true,
        textureSize: Vector2(640, 360),
        amountPerRow: 8,
      )
    );

    animations = {
      State.idle: idle,
      State.breathing1: breathing1,
      State.breathing2: breathing2,
      State.lose: lose,
      State.win: win,
    };
  }
}