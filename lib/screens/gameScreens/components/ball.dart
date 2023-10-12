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

  Vector2 vector2FromAngle(double angle) {
    return Vector2(cos(angle), sin(angle));
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // Rect otherRect = Rect.fromPoints(
    //   Offset(other.x, other.y),
    //   Offset(other.x + other.width, other.y + other.height),
    // );
    // final rectCenter = otherRect.topCenter.toVector2();
    // final ballPosition = position;
    // final vector = ballPosition - rectCenter;
    // final angle = atan2(vector.y, vector.x);
    // final reflectedAngle = pi - angle;
    // final randomOffset = Random().nextDouble() * 0.5 - 0.25;
    // final finalAngle = reflectedAngle + randomOffset;

    // final angle = atan2(velocity.y, velocity.x);

    // // Randomly add or subtract a small offset to the angle
    // final offset = 5;
    // final newAngle = angle + offset;

    if (other is Player) {
      // velocity.y *= -1;
      // velocity = vector2FromAngle(newAngle);
      // Calculate the angle of the ball's movement
      final angle = atan2(velocity.y, velocity.x);
      final reflectedAngle = pi - angle;
      velocity = vector2FromAngle(reflectedAngle);
      velocity.y *= -1;
    } else if (other is Brick) {
      // velocity.y *= -1;
      final angle = atan2(velocity.y, velocity.x);
      final reflectedAngle = pi - angle;
      velocity = vector2FromAngle(reflectedAngle);
      velocity.y *= -1;
    } else if (other is Boundary) {
      if (other.isBottom) {}
      if (position.x < 0 || position.x > game.size.x - (width)) {
        velocity.x *= -1;
      }
      if (position.y < 0 || position.y > game.size.y - (height)) {
        velocity.y *= -1;
      }
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    position += velocity * 200 * dt;
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
