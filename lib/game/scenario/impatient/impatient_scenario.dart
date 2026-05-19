import 'package:flame/events.dart';
import 'package:mindscape/game/main_game.dart';
import 'package:mindscape/game/scenario/scenario.dart';

class ImpatientScenario extends Scenario with TapCallbacks {
  ImpatientScenario({required super.timeSecond});

  @override
  void onLose() {
    // TODO: implement onLose
  }

  @override
  void onWin() {
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