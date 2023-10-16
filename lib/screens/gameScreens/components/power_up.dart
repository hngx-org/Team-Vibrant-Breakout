import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/power_up_enum.dart';

class PowerUp extends SpriteComponent {
  PowerUp(
      {required this.powerSprite,
      required this.ability,
      required this.powerPosition,})
      : super(
          sprite: powerSprite,
          position: powerPosition,
          size: Vector2(100, 20),
          children: [
            RectangleHitbox(),
          ]
        );

  Sprite powerSprite;
  PowerUpEnum ability;
  Vector2 powerPosition;

  @override
  void update(double dt) {
    position += Vector2(0, 1) * 60 * dt;
    super.update(dt);
  }

  void activatePowerUp() {
    switch (ability) {
      case PowerUpEnum.increaseBallSpeed:
        break;
      case PowerUpEnum.increaseLife:
        break;
      case PowerUpEnum.increaseScore:
        break;
    }
  }
}
