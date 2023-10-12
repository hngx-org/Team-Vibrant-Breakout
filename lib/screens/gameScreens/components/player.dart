import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
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
  void update(double dt) {
    super.update(dt);
    position.x += speed * dt;
  }

  void moveLeft() {
    x -= speed;
  }

  void moveRight() {
    x += speed;
  }
}
