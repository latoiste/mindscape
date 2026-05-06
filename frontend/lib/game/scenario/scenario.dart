import 'package:flame/components.dart';
import 'package:mindscape/game/main_game.dart';

abstract class Scenario extends PositionComponent with HasGameReference<MainGame> {
  late final Sprite background;

  void onWin();
  void onFail();
  
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    size = game.size;
  }

  @override
  void onRemove() {
    // need to dispose everything
    background.image.dispose();
  }
}
