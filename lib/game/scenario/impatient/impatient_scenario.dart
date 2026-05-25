import 'package:flame/events.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/game/scenario/scenario.dart';

class ImpatientScenario extends Scenario with TapCallbacks {
  ImpatientScenario({required super.timeSecond, required super.backgroundPath});

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
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);

    super.gameEndNotifier.value = GameResult.lose;
  }

  @override
  void onTimerEnd() {
    super.gameEndNotifier.value = GameResult.win;
  }
}