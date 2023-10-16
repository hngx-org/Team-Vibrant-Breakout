import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:get/get.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/brick_game_base_class.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/ball.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/power_up.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/power_up_enum.dart';
// import 'package:team_vibrant_breakout/screens/gameScreens/game.dart';

import '../../../constants/controllers.dart';

class Brick extends SpriteComponent
    with CollisionCallbacks, HasGameRef<BrickGameBaseClass> {
  ScoreController scoreController = Get.put(ScoreController());

  Brick({
    required this.brickSprite,
    required this.brickPosition,
  }) : super(
          sprite: brickSprite,
        );

  PowerUp? brickPowerUp;
  late PowerUp increaseLifePowerUp;
  late PowerUp increaseScorePowerUp;
  late PowerUp increaseSpeedPowerUp;
  bool isDestroyed = false;

  // Future<PowerUp?> selectPUp(int index) async {
  //   List<PowerUp> powerUps = [
  //     increaseScorePowerUp,
  //     increaseSpeedPowerUp,
  //   ];
  //   if (index >= 0 && index < 3) {
  //     return powerUps[index];
  //   }
  //   return null;
  // }

  @override
  FutureOr<void> onLoad() async {
    position = brickPosition;
    increaseLifePowerUp = PowerUp(
      powerSprite: await Sprite.load('life.png'),
      ability: PowerUpEnum.increaseLife,
      powerPosition: position,
    );
    increaseScorePowerUp = PowerUp(
      powerSprite: await Sprite.load('100.png'),
      ability: PowerUpEnum.increaseScore,
      powerPosition: position,
    );
    increaseSpeedPowerUp = PowerUp(
      powerSprite: await Sprite.load('fast.png'),
      ability: PowerUpEnum.increaseBallSpeed,
      powerPosition: position,
    );
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
  void onCollision(
      Set<Vector2> intersectionPoints, PositionComponent other) async {
    if (other is Ball) {
      scoreController.updateScore(scoreController.score.value + 50);
      var rand = Random().nextInt(8);
      if (rand >= 0 && rand < 2) {
        brickPowerUp = [
          increaseScorePowerUp,
          increaseSpeedPowerUp,
        ][rand];
        await game.add(brickPowerUp!);
      }
      
      removeFromParent();
    }
    super.onCollision(intersectionPoints, other);
  }

  Sprite brickSprite;
  Vector2 brickPosition;
}
