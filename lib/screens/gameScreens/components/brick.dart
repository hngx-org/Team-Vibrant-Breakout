import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/ball.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/game.dart';

class Brick extends SpriteComponent
    with CollisionCallbacks, HasGameRef<BrickGame> {
  Brick({
    required this.brickSprite,
    required this.brickPosition,
  }) : super(
          sprite: brickSprite,
        );

  @override
  FutureOr<void> onLoad() async {
    position = brickPosition;
    size = Vector2(game.size.x / 5, 30);
    await add(RectangleHitbox());

    return super.onLoad();
  }

  @override
  void update(double dt) {
    moveDown();
    super.update(dt);
  }

  void moveDown() {
    position.y + 30;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Ball) {
      gameRef.score++;
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  Sprite brickSprite;
  Vector2 brickPosition;
}
