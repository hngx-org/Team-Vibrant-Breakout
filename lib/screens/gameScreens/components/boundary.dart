import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/brick_game_base_class.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/game.dart';

class Boundary extends SpriteComponent
    with CollisionCallbacks, HasGameRef<BrickGameBaseClass> {
  Boundary({
    required Vector2 position,
    required Vector2 size,
    this.isBottom = false,
    required this.boundarySprite,
  }) : super(
          sprite: boundarySprite,
        ) {
    this.position = position;
    this.size = size;
  }

  Sprite boundarySprite;
  bool isBottom;

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox());
    return super.onLoad();
  }
}
