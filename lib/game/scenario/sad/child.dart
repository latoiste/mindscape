import 'dart:async';

import 'package:flame/components.dart';
import 'package:mindscape/game/main_game.dart';

enum State { idle, win, lose }

class Child extends SpriteAnimationGroupComponent<State> with HasGameReference<MainGame>, HasVisibility {
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

    position = Vector2(0, game.worldSize.y/6);

    await prepareAnimations();
    current = State.idle;
  }

  void changeAnimation(String animationName) {
    switch (animationName) {
      case "idle":
        current = State.idle;
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
      game.images.fromCache("scenario_2/idle.png"), 
      SpriteAnimationData.sequenced(
        amount: 30, 
        stepTime: .1, 
        loop: false,
        textureSize: Vector2(1280, 720),
        amountPerRow: 6,
      )
    );
    lose = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_2/lose.png"), 
      SpriteAnimationData.sequenced(
        amount: 30, 
        stepTime: .1, 
        loop: false,
        textureSize: Vector2(1280, 720),
        amountPerRow: 6,
      )
    );
    win = SpriteAnimation.fromFrameData(
      game.images.fromCache("scenario_2/win.png"), 
      SpriteAnimationData.sequenced(
        amount: 30, 
        stepTime: .1, 
        loop: false,
        textureSize: Vector2(1280, 720),
        amountPerRow: 6,
      )
    );

    animations = {
      State.idle: idle,
      State.lose: lose,
      State.win: win,
    };
  }
}