import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/ball.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/boundary.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/brick.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/player.dart';

class BrickGame extends FlameGame
    with TapCallbacks, KeyboardHandler, HasCollisionDetection {
  BrickGame() : super();

  late Player player;
  late TextComponent currentScore;
  int score = 0;
  final boundaries = <Boundary>[];
  late JoystickComponent joystick;
  late Ball ball;

  // @override
  // void onTapDown(TapDownInfo info) {
  // if (info.eventPosition.widget[0] > player.position[0] &&
  //     player.position[0] < size[0] - 100) {
  //   player.position[0] += 2;
  // } else if (info.eventPosition.widget[0] < player.position[0] &&
  //     player.position[0] > 0) {
  //   player.position[0] -= 2;
  // }
  //   super.onTapDown(info);
  // }

  @override
  void onTapDown(TapDownEvent event) {
    if (event.localPosition[0] > player.position[0] &&
        player.position[0] < size[0] - 100) {
      player.moveRight();
    } else if (event.localPosition[0] < player.position[0] &&
        player.position[0] > 0) {
      player.moveLeft();
    }
    super.onLongTapDown(event);
  }

  @override
  FutureOr<void> onLoad() async {
    ball = Ball(ballSprite: await Sprite.load('ball.png'));
    boundaries.add(Boundary(
      position: Vector2(0, 0),
      size: Vector2(size[0], 10),
      boundarySprite: await Sprite.load('wall.png'),
    ));
    boundaries.add(
      Boundary(
        position: Vector2(0, 0),
        size: Vector2(10, size[1]),
        boundarySprite: await Sprite.load('wall.png'),
      ),
    );
    boundaries.add(
      Boundary(
        position: Vector2(0, size[1] - 10),
        size: Vector2(size[0], 10),
        boundarySprite: await Sprite.load('wall.png'),
        isBottom: true
      ),
    );
    boundaries.add(
      Boundary(
        position: Vector2(size[0] - 10, size[1]),
        size: Vector2(10, size[1]),
        boundarySprite: await Sprite.load('wall.png'),
      ),
    );
    List<Brick> bricks = [];
    List.generate(size[0] ~/ 80, (index) async {
      var random = Random().nextInt(4);
      bricks.add(
        Brick(
          brickSprite: await Sprite.load('tile${random + 1}.png'),
          brickPosition: Vector2(index * 80, 0),
        ),
      );
    });
    joystick = JoystickComponent(
      size: 10,
      position: Vector2(0, 0),
      knob: PositionComponent(),
    );
    currentScore = TextComponent(
      text: score.toString(),
      position: Vector2(size[0] / 2 - 10, 10),
    );
    player = Player(
      playerSprite: await Sprite.load('player.png'),
      playerSize: size,
      speed: 10,
    );
    await add(player);
    await add(joystick);
    await add(ball);
    await addAll(bricks);
    // await addAll(boundaries);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    player.position.x += joystick.x * player.speed * dt;
    // if (player.position.x < 0) {
    //   player.position.x = 0;
    // } else if (player.position.x > size[0] - player.size[0]) {
    //   player.position.x = size.x - player.size.x;
    // }
    super.update(dt);
  }
}
