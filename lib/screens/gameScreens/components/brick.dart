import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:get/get.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/ball.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/game.dart';

import '../../../constants/controllers.dart';

class Brick extends SpriteComponent
    with CollisionCallbacks, HasGameRef<BrickGame> {
  ScoreController scoreController = Get.put(ScoreController());

  Brick({
    required this.brickSprite,
    required this.brickPosition,
  }) : super(
          sprite: brickSprite,
          size: Vector2(80, 40),
          position: brickPosition,
        );

  @override
  FutureOr<void> onLoad() async {
    await add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ball) {
      scoreController.updateScore(scoreController.score.value + 50);
      gameRef.brickDestroyed();
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  Sprite brickSprite;
  Vector2 brickPosition;
}
