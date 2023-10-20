import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/src/services/raw_keyboard.dart';
import 'package:flutter/src/widgets/focus_manager.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/brick_game_base_class.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/ball.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/boundary.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/brick.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/player.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/gameOver.dart';
import 'package:team_vibrant_breakout/screens/stageComplete.dart';

class Level2 extends BrickGameBaseClass
    with TapCallbacks, KeyboardEvents, HasCollisionDetection, DragCallbacks {
  Level2() : super();

  @override
  int score = 0;

  late Player player;
  late TextComponent currentScore;
  List<List<Brick>> brickLayer = [];

  late double yLocus;
  late double newDt;
  final boundaries = <Boundary>[];
  bool tapping = false;
  bool emptyBricks = false;
  int totalBricks = 0;
  TapDownEvent? event;
  late Ball ball;

  List<Brick> bricks1 = [];

  @override
  void onTapDown(TapDownEvent event) {
    tapping = true;
    this.event = event;
    super.onTapDown(event);
  }

  void brickLayerMovement() async {
    // for (int i = 0; i < brickLayer.length; i++) {
    //   for (int j = 0; j < brickLayer[i].length; j++) {
    //     brickLayer[i][j].position.setValues(
    //           brickLayer[i][j].position.x,
    //           brickLayer[i][j].position.y + 30,
    //         );
    //     brickLayer[i][j].update(dt);
    //   }
    // }
    for (var bricks in brickLayer) {
      for (var brick in bricks) {
        brick.moveDown();
      }
    }
    List<Brick> newBrick = [];
    List.generate(size[0] ~/ (size.x / 5), (index) async {
      var random = Random().nextInt(4);
      newBrick.add(
        Brick(
          brickSprite: await Sprite.load('tile${random + 1}.png'),
          brickPosition: Vector2(index * (size.x / 5), yLocus),
        ),
      );
    });
    brickLayer.add(newBrick);
  }

  @override
  void onTapUp(TapUpEvent event) {
    tapping = false;
    super.onTapUp(event);
  }

  // @override
  // void onDragStart(DragStartEvent event) {
  //   if (event.localPosition[0] > player.position[0] &&
  //       player.position[0] < size[0] - 100) {
  //     player.moveLeft();
  //   } else if (event.localPosition[0] < player.position[0] &&
  //       player.position[0] > 0) {
  //     player.moveRight(size[0]);
  //   }
  //   super.onDragStart(event);
  // }

  // @override
  // void onDragUpdate(DragUpdateEvent event) {
  //   if (event.localPosition[0] > player.position[0] &&
  //       player.position[0] < size[0] - 100) {
  //     player.moveLeft();
  //   } else if (event.localPosition[0] < player.position[0] &&
  //       player.position[0] > 0) {
  //     player.moveRight(size[0]);
  //   }
  //   super.onDragUpdate(event);
  // }

  @override
  void gameOver() {
    // Reset score
    score = 0;

    // Reset ball position
    ball.position = Vector2(size.x / 2, size.y / 2);

    // Reset player position
    player.position = Vector2(size.x / 2 - 50, size.y - 50);

    // Show game over screen
    Get.off(() => GameOver());
    super.gameOver();
  }

  void gameReset() {
    // Reset score
    score = 0;

    // Reset ball position
    ball.position = Vector2(size.x / 2, size.y / 2);

    // Reset player position
    player.position = Vector2(size.x / 2 - 50, size.y - 50);
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        player.moveLeft(newDt);
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        player.moveRight(size[0] - (player.width + 5), newDt);
      }
    }
    return KeyEventResult.handled;
  }

  @override
  FutureOr<void> onLoad() async {
    ball = Ball(
      ballSprite: await Sprite.load('ball.png'),
    );
    yLocus = 0;
    boundaries.add(
      Boundary(
        position: Vector2(0, 0),
        size: Vector2(size[0], 1),
        boundarySprite: await Sprite.load('wall.png'),
      ),
    );
    boundaries.add(
      Boundary(
        position: Vector2(0, 0),
        size: Vector2(1, size[1]),
        boundarySprite: await Sprite.load('wall.png'),
      ),
    );
    boundaries.add(
      Boundary(
          position: Vector2(0, size[1] - 1),
          size: Vector2(size[0], 10),
          boundarySprite: await Sprite.load('wall.png'),
          isBottom: true),
    );
    boundaries.add(
      Boundary(
        position: Vector2(size[0] - 1, size[1]),
        size: Vector2(10, size[1]),
        boundarySprite: await Sprite.load('wall.png'),
      ),
    );
    List<Brick> bricks2 = [];
    List<Brick> bricks3 = [];
    List<Brick> bricks4 = [];
    List<Brick> bricks5 = [];
    List<Brick> bricks6 = [];
    List<Brick> bricks7 = [];

    List.generate(size[0] ~/ (size.x / 5), (index) async {
      totalBricks++;
      var random = Random().nextInt(4);
      bricks1.add(
        Brick(
          brickSprite: await Sprite.load('tile${random + 1}.png'),
          brickPosition: Vector2(index * (size.x / 5), yLocus),
        ),
      );
    });
    List.generate(size[0] ~/ (size.x / 5), (index) async {
      var random = Random().nextInt(4);
      if (index % 2 == 0) {
        totalBricks++;
        {
          bricks2.add(
            Brick(
              brickSprite: await Sprite.load('tile${random + 1}.png'),
              brickPosition: Vector2(index * (size.x / 5), yLocus + 30),
            ),
          );
        }
      }
    });
    List.generate(size[0] ~/ (size.x / 5), (index) async {
      var random = Random().nextInt(4);
      if (index % 2 == 0) {
        totalBricks++;
        {
          bricks3.add(
            Brick(
              brickSprite: await Sprite.load('tile${random + 1}.png'),
              brickPosition: Vector2(index * (size.x / 5), yLocus + 60),
            ),
          );
        }
      }
    });
    List.generate(size[0] ~/ (size.x / 5), (index) async {
      totalBricks++;
      var random = Random().nextInt(4);
      bricks4.add(
        Brick(
          brickSprite: await Sprite.load('tile${random + 1}.png'),
          brickPosition: Vector2(index * (size.x / 5), yLocus + 90),
        ),
      );
    });
    List.generate(size[0] ~/ (size.x / 5), (index) async {
      totalBricks++;
      var random = Random().nextInt(4);
      bricks5.add(
        Brick(
          brickSprite: await Sprite.load('tile${random + 1}.png'),
          brickPosition: Vector2(index * (size.x / 5), yLocus + 120),
        ),
      );
    });
    List.generate(size[0] ~/ (size.x / 5), (index) async {
      totalBricks++;
      var random = Random().nextInt(2);
      bricks6.add(
        Brick(
          brickSprite: await Sprite.load('tile${random + 1}.png'),
          brickPosition: Vector2(index * (size.x / 5), yLocus + 150),
        ),
      );
    });

    List.generate(size[0] ~/ (size.x / 5), (index) async {
      var random = Random().nextInt(4);
      if (index % 3 == 0) {
        totalBricks++;
        {
          bricks7.add(
            Brick(
              brickSprite: await Sprite.load('tile${random + 1}.png'),
              brickPosition: Vector2(index * (size.x / 5), yLocus + 180),
            ),
          );
        }
      }
    });

    brickLayer.add(bricks1);
    brickLayer.add(bricks2);
    brickLayer.add(bricks3);
    brickLayer.add(bricks4);
    brickLayer.add(bricks5);
    brickLayer.add(bricks6);
    brickLayer.add(bricks7);

    // currentScore = TextComponent(
    //   text: score.toString(),
    //   position: Vector2(size[0] / 2 - 10, 10),
    // );
    // await add(currentScore);

    player = Player(
      playerSprite: await Sprite.load('player.png'),
      playerSize: size,
      speed: 10,
    );
    await add(player);
    await add(ball);
    for (var element in brickLayer.reversed) {
      addAll(element);
    }
    await addAll(boundaries);
    return super.onLoad();
  }

  @override
  void update(double dt) async {
    // if (player.position.x < 0) {
    //   player.position.x = 0;
    // } else if (player.position.x > size[0] - player.size[0]) {
    //   player.position.x = size.x - player.size.x;
    // }
    newDt = dt;
    if (tapping) {
      player.update(dt, event: event);
    }
    ball.update(dt);
    // if (ball.destroyedBricks == 2) {
    //   brickLayerMovement();
    //   for (var bricks in brickLayer.reversed) {
    //     for (Brick brick in bricks) {
    //       brick.update(dt);
    //       if (brick.isMounted) {
    //         remove(brick);
    //       }
    //     }
    //   }
    //   for (var bricks in brickLayer.reversed) {
    //     for (var brick in bricks) {
    //       await add(brick);
    //     }
    //   }
    //   ball.destroyedBricks = 0;
    // }
    // currentScore.text = score.toString();
    if (totalBricks == ball.destroyedBricks) {
      levelCompleteSound.resume();
      Get.off(() => LevelComplete());
    }

    super.update(dt);
  }
}
