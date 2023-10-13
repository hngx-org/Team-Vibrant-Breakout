import 'package:flame/game.dart';

abstract class BrickGameBaseClass extends FlameGame {
  BrickGameBaseClass();
  int score = 0;
  void gameOver() {}
}
