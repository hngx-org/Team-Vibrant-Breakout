import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:get/get.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:flame/game.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_vibrant_breakout/constants/controllers.dart';
// import 'package:flame_audio/flame_audio.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/brick_game_base_class.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/boundary.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/brick.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/player.dart';
// import 'package:team_vibrant_breakout/screens/gameScreens/components/power_up.dart';
// import 'package:team_vibrant_breakout/screens/gameScreens/game.dart';

class Ball extends SpriteComponent
    with CollisionCallbacks, HasGameRef<BrickGameBaseClass> {
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
  double ballSpeed = 0;
  double ySign = 1;

  late int destroyedBricks;

  ScoreController scoreController = Get.put(ScoreController());

  AudioPlayer playerSound = AudioPlayer();
  AudioPlayer brickSound = AudioPlayer();
  AudioPlayer wallSound = AudioPlayer();

  SharedPreferences? _prefs;

  @override
  FutureOr<void> onLoad() async {
    await playerSound.setSource(AssetSource('audio/player_hit.wav'));
    // await wallSound.setAssetUrl('assets/audio/hit.wav');
    await brickSound.setSource(AssetSource('audio/block_hit.wav'));

    ballSpeed = scoreController.ballSpeed.value;
    destroyedBricks = 0;
    _prefs = await SharedPreferences.getInstance();
    position = Vector2(game.size.x / 2, game.size.y / 2);
    // add(CircleHitbox());
    return super.onLoad();
  }

  Vector2 vector2FromAngle(double angle) {
    return Vector2(cos(angle), sin(angle));
  }

  @override
  void onCollision(
      Set<Vector2> intersectionPoints, PositionComponent other) async {
    Rect otherRect = Rect.fromPoints(
      Offset(other.x, other.y),
      Offset(other.x + other.width, other.y + other.height),
    );
    Rect thisRect = Rect.fromPoints(
      Offset(x, y),
      Offset(x + width, y + height),
    );
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
      // FlameAudio.play('audio/hit.wav');
      playerSound.resume();
      if (otherRect.overlaps(thisRect)) {
        Rect intersection = thisRect.intersect(otherRect);
        if (intersection.height < intersection.width &&
            position.y < other.position.y) {
          position =
              Offset(position.x, position.y - intersection.height).toVector2();
          double paddlePct =
              (position.x + width / 2 - other.position.x) / other.width;
          double maxAngle = pi * .8;
          velocity = Offset.fromDirection(-maxAngle + maxAngle * paddlePct)
              .toVector2();
        } else if (position.x < other.position.x) {
          position = Offset(other.position.x - width, position.y).toVector2();
          velocity = Offset.fromDirection(-velocity.x.abs(), velocity.y.abs())
              .toVector2();
        } else if (position.x > other.position.x) {
          position = Offset(other.position.x, position.y).toVector2();
          velocity = Offset.fromDirection(-velocity.x.abs(), velocity.y.abs())
              .toVector2();
        } else {
          // position = Offset(position.x, otherRect.bottom).toVector2();
          // velocity = Offset(0, velocity.y.abs()).toVector2();
        }
      }
      // playerSound.stop();
    } else if (other is Brick) {
      destroyedBricks++;
      gameRef.score += 50; // Increase score by 50
      _prefs?.setInt('score', gameRef.score);
      // FlameAudio.play('audio/shot.wav');
      brickSound.resume();
      if (otherRect.overlaps(thisRect)) {
        Rect intersection = thisRect.intersect(otherRect);
        if (intersection.height > intersection.width) {
          position = Offset(
                  position.x - intersection.width * velocity.x.sign, position.y)
              .toVector2();
          velocity = Offset(-velocity.x, velocity.y).toVector2();
        } else {
          position = Offset(
                  position.x, position.y - intersection.width * velocity.y.sign)
              .toVector2();
          velocity = Offset(velocity.x, -velocity.y).toVector2();
        }
      }
    } else if (other is Boundary) {
      // FlameAudio.play('audio/hit.wav');
      if (!other.isBottom) {
        if (position.x < 0 || position.x > game.size.x - (width)) {
          velocity.x *= -1;
        }
        if (position.y < 0 || position.y > game.size.y - (height)) {
          velocity.y *= -1;
        }
      }
    }

    super.onCollision(intersectionPoints, other);
  }

  @override
  void update(double dt) {
    position += velocity * ballSpeed * dt;
    // x += 100 * cos(angle) * dt;
    // y += 100 * sin(angle) * dt;
    // int rand = Random(1).nextInt(90);
    // angle += 2 * pi * rand;

    if (position.x < 0 || position.x > game.size.x - (width)) {
      velocity.x *= -1;
      // angle = pi - angle;
    }
    if (position.y < 0) {
      // || position.y > game.size.y - (height)) {
      // angle = -angle;

      velocity.y *= -1;
    }

    if (position.y > game.size.y - (height)) {
      // Ball is below the player's position, triggering game over
      gameRef.gameOver();
      return;
    }

    super.update(dt);
  }
}
