import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/boundary.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/brick.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/player.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/game.dart';


class Ball extends SpriteComponent
    with CollisionCallbacks, HasGameRef<BrickGame> {
  Ball({required this.ballSprite})
      : super(
          sprite: ballSprite,
          size: Vector2(20, 20),
          children: [
            CircleHitbox(),
          ],
        );
  Vector2 velocity = Vector2(0, 1);
  Sprite ballSprite;
  double xSign = 1;

  double ySign = 1;
  // @override
  // void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
  //   if (other is Brick) {
  //     int rand = Random(1).nextInt(90);
  //     angle += 2 * pi * rand;
  //     velocity.y *= -1;
  //   } else if (other is Player) {
  //     int rand = Random(1).nextInt(90);
  //     angle += 2 * pi * rand;
  //     velocity.y *= -1;
  //   }
  //   super.onCollision(intersectionPoints, other);
  // }

  @override
  FutureOr<void> onLoad() {
    position = Vector2(game.size.x / 2, game.size.y / 2);
    // add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    Rect otherRect = Rect.fromPoints(
      Offset(other.x, other.y),
      Offset(other.x + other.width, other.y + other.height),
    );
    final rectCenter = otherRect.center.toVector2();
    final ballPosition = position;
    final vector = ballPosition - rectCenter;
    final angle = atan2(vector.y, vector.x);    

    if (other is Player) {
      // velocity.y *= -1;
      velocity = Vector2.all(angle);
    } else if (other is Brick) {
      // velocity.y *= -1;
      velocity = Vector2.all(angle);
    } else if (other is Boundary) {
      if (other.isBottom) {
        print('lost');
      }
      velocity = Vector2.all(angle);
    }
    velocity *= 2;
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    position += velocity * 100 * dt;
    // x += 100 * cos(angle) * dt;
    // y += 100 * sin(angle) * dt;
    // int rand = Random(1).nextInt(90);
    // angle += 2 * pi * rand;

    if (position.x < 0 || position.x > game.size.x - (width)) {
      velocity.x *= -1;
      // angle = pi - angle;
    }
    if (position.y < 0 || position.y > game.size.y - (height)) {
      // angle = -angle;

      velocity.y *= -1;
    }

    super.update(dt);
  }
}
