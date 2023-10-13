import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/game.dart';

class Player extends SpriteComponent
    with CollisionCallbacks, HasGameRef<BrickGame> {
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

  @override
  FutureOr<void> onLoad() async {
    await add(RectangleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt, {TapDownEvent? event}) {
    // position.x += speed * dt;
    if (event != null) {
      movement(event);
    }
    super.update(dt);
  }

  void movement(TapDownEvent event) {
    if (event.localPosition[0] >= game.size[0] / 2 &&
        position[0] < game.size[0] - 100) {
      moveRight(game.size[0]);
    } else if (event.localPosition[0] < game.size[0] / 2 && position[0] > 0) {
      moveLeft();
    }
  }

  void moveLeft() {
    if (position.x > 0) {
      x -= speed;
    }
  }

  void moveRight(double size) {
    if (position.x < size) {
      x += speed;
    }
  }
}
