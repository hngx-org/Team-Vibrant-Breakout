import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:get/get.dart';
import 'package:team_vibrant_breakout/constants/controllers.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/brick_game_base_class.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/power_up.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/power_up_enum.dart';

class Player extends SpriteComponent
    with CollisionCallbacks, HasGameRef<BrickGameBaseClass> {
  Player({
    required this.playerSprite,
    required this.playerSize,
    required this.speed,
  }) : super(
          sprite: playerSprite,
          size: Vector2(100, 20),
          position: Vector2(
            playerSize[0] / 2 - 50,
            playerSize[1] - 50,
          ),
        );

  Sprite playerSprite;
  Vector2 playerSize;
  int speed;
  ScoreController scoreController = Get.put(ScoreController());

  @override
  FutureOr<void> onLoad() async {
    await add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is PowerUp) {
      switch (other.ability) {
        case PowerUpEnum.increaseBallSpeed:
          scoreController.adjustBallSpeed(20);
          break;
        case PowerUpEnum.increaseScore:
          scoreController.updateScore(scoreController.score.value + 100);
          break;
        default:
      }
      other.removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt, {TapDownEvent? event}) {
    // position.x += speed * dt;
    if (event != null) {
      movement(event, dt);
    }
    super.update(dt);
  }

  void movement(TapDownEvent event, double dt) {
    if (event.localPosition[0] >= game.size[0] / 2 &&
        position[0] < game.size[0] - 100) {
      moveRight(game.size[0], dt);
    } else if (event.localPosition[0] < (game.size[0] / 2) - 10 &&
        position[0] > 0) {
      moveLeft(dt);
    }
  }

  void moveLeft(double dt) {
    if (position.x > 0) {
      x -= speed * 50 * dt;
    }
  }

  void moveRight(double size, double dt) {
    if (position.x < size) {
      x += speed * 50 * dt;
    }
  }
}
