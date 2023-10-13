import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:flutter/src/services/raw_keyboard.dart';
import 'package:flutter/src/widgets/focus_manager.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/ball.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/boundary.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/brick.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/components/player.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/gameOver.dart';

import '../stageComplete.dart';

class BrickGame extends FlameGame
    with TapCallbacks, KeyboardEvents, HasCollisionDetection, DragCallbacks {
  BrickGame() : super();

  late Player player;
  late TextComponent currentScore;
  List<List<Brick>> brickLayer = [];
  int score = 0;
  late double yLocus;
  final boundaries = <Boundary>[];
  bool tapping = false;
  TapDownEvent? event;
  late Ball ball;

  @override
  void onTapDown(TapDownEvent event) {
    tapping = true;
    this.event = event;
    super.onTapDown(event);
  }

  void brickLayerMovement() {
    bool emptyBricks = false;
    for (List<Brick> bricks in brickLayer) {
      for (Brick brick in bricks) {
        if (brick.isRemoved == true) {
          bricks.remove(brick);
        }
      }
      if (bricks.isEmpty) {
        emptyBricks = true;
        brickLayer.remove(bricks);
        for (int i = 0; i < brickLayer.length; i++) {
          for (int j = 0; j < brickLayer[i].length; j++) {
            brickLayer[i][j].brickPosition = Vector2(
                brickLayer[i][j].brickPosition.x,
                brickLayer[i][j].brickPosition.y + 40);
          }
        }
      }
    }
    if (emptyBricks) {
      List<Brick> newBricks = [];
      List.generate(size[0] ~/ 80, (index) async {
        var random = Random().nextInt(4);
        if (index % 2 == 0) {
          {
            newBricks.add(
              Brick(
                brickSprite: await Sprite.load('tile${random + 1}.png'),
                brickPosition: Vector2(index * 80, yLocus),
              ),
            );
          }
        }
      });
      brickLayer.insert(0, newBricks);
    }
  }

  @override
  void onTapUp(TapUpEvent event) {
    tapping = false;
    super.onTapUp(event);
  }

  @override
  void onDragStart(DragStartEvent event) {
    if (event.localPosition[0] > player.position[0] &&
        player.position[0] < size[0] - 100) {
      player.moveLeft();
    } else if (event.localPosition[0] < player.position[0] &&
        player.position[0] > 0) {
      player.moveRight(size[0]);
    }
    super.onDragStart(event);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    if (event.localPosition[0] > player.position[0] &&
        player.position[0] < size[0] - 100) {
      player.moveLeft();
    } else if (event.localPosition[0] < player.position[0] &&
        player.position[0] > 0) {
      player.moveRight(size[0]);
    }
    super.onDragUpdate(event);
  }

  int totalBricks = 0;

  void brickDestroyed() {
    totalBricks--;

    if (totalBricks == 0) {
      // All bricks are cleared, show congratulatory message and navigate
      showCongratulatoryPage();
    }
  }

  void showCongratulatoryPage() {
    // Navigate to congratulatory page or show a message
    Get.off(() => LevelComplete());
  }

  void gameOver() {
    // Reset score
    score = 0;

    // Reset ball position
    ball.position = Vector2(size.x / 2, size.y / 2);

    // Reset player position
    player.position = Vector2(size.x / 2 - 50, size.y - 50);

    // Show game over screen
    Get.off(() => GameOver());
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        player.moveLeft();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        player.moveRight(size[0] - (player.width + 5));
      }
    }
    return KeyEventResult.handled;
  }

  @override
  FutureOr<void> onLoad() async {
    ball = Ball(ballSprite: await Sprite.load('ball.png'));
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
    List<List<Brick>> brickLayer = [];
    List<Brick> bricks1 = [];
    List<Brick> bricks2 = [];
    List<Brick> bricks3 = [];
    List<Brick> bricks4 = [];

    List.generate(size[0] ~/ 80, (index) async {
      var random = Random().nextInt(4);
      bricks1.add(
        Brick(
          brickSprite: await Sprite.load('tile${random + 1}.png'),
          brickPosition: Vector2(index * 80, yLocus),
        ),
      );
    });
    List.generate(size[0] ~/ 80, (index) async {
      var random = Random().nextInt(4);
      if (index % 2 == 0) {
        {
          bricks2.add(
            Brick(
              brickSprite: await Sprite.load('tile${random + 1}.png'),
              brickPosition: Vector2(index * 80, yLocus + 40),
            ),
          );
        }
      }
    });
    List.generate(size[0] ~/ 80, (index) async {
      var random = Random().nextInt(4);
      if (index % 3 == 0) {
        {
          bricks3.add(
            Brick(
              brickSprite: await Sprite.load('tile${random + 1}.png'),
              brickPosition: Vector2(index * 80, yLocus + 80),
            ),
          );
        }
      }
    });
    List.generate(size[0] ~/ 80, (index) async {
      var random = Random().nextInt(4);
      bricks4.add(
        Brick(
          brickSprite: await Sprite.load('tile${random + 1}.png'),
          brickPosition: Vector2(index * 80, 120),
        ),
      );
    });
    brickLayer.addAll([bricks1, bricks2, bricks3, bricks4]);
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
    for (var element in brickLayer) {
      addAll(element);
    }
    await addAll(boundaries);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // if (player.position.x < 0) {
    //   player.position.x = 0;
    // } else if (player.position.x > size[0] - player.size[0]) {
    //   player.position.x = size.x - player.size.x;
    // }
    if (tapping) {
      player.update(dt, event: event);
    }
    ball.update(dt);
    // brickLayerMovement();

    // currentScore.text = score.toString();

    super.update(dt);
  }
}
