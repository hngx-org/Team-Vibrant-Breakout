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
      gameRef.score++;
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  Sprite brickSprite;
  Vector2 brickPosition;
}
