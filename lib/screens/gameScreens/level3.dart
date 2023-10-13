// import 'dart:async';
// import 'dart:math';
// import 'package:flame/components.dart';
// import 'package:flame/events.dart';
// import 'package:flame/game.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/src/services/keyboard_key.g.dart';
// import 'package:flutter/src/services/raw_keyboard.dart';
// import 'package:flutter/src/widgets/focus_manager.dart';
// import 'package:team_vibrant_breakout/screens/gameScreens/components/ball.dart';
// import 'package:team_vibrant_breakout/screens/gameScreens/components/boundary.dart';
// import 'package:team_vibrant_breakout/screens/gameScreens/components/brick.dart';
// import 'package:team_vibrant_breakout/screens/gameScreens/components/player.dart';

// class BrickGame extends FlameGame
//     with TapCallbacks, KeyboardEvents, HasCollisionDetection {
//   BrickGame() : super();

//   late Player player;
//   late TextComponent currentScore;
//   int score = 0;
//   final boundaries = <Boundary>[];
//   late Ball ball;

//   // @override
//   // void onTapDown(TapDownInfo info) {
//   // if (info.eventPosition.widget[0] > player.position[0] &&
//   //     player.position[0] < size[0] - 100) {
//   //   player.position[0] += 2;
//   // } else if (info.eventPosition.widget[0] < player.position[0] &&
//   //     player.position[0] > 0) {
//   //   player.position[0] -= 2;
//   // }
//   //   super.onTapDown(info);
//   // }

//   // @override
//   // void onTapDown(TapDownEvent event) {
//   //   if (event.localPosition[0] > player.position[0] &&
//   //       player.position[0] < size[0] - 100) {
//   //     player.moveRight();
//   //   } else if (event.localPosition[0] < player.position[0] &&
//   //       player.position[0] > 0) {
//   //     player.moveLeft();
//   //   }
//   //   super.onLongTapDown(event);
//   // }

//   @override
//   KeyEventResult onKeyEvent(
//       RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
//     if (event is RawKeyDownEvent) {
//       if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
//         player.moveLeft();
//       } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
//         player.moveRight(size[0] - (player.width + 5));
//       }
//     }
//     return KeyEventResult.handled;
//   }

//   @override
//   FutureOr<void> onLoad() async {
//     ball = Ball(ballSprite: await Sprite.load('ball.png'));
//     boundaries.add(
//       Boundary(
//         position: Vector2(0, 0),
//         size: Vector2(size[0], 1),
//         boundarySprite: await Sprite.load('wall.png'),
//       ),
//     );
//     boundaries.add(
//       Boundary(
//         position: Vector2(0, 0),
//         size: Vector2(1, size[1]),
//         boundarySprite: await Sprite.load('wall.png'),
//       ),
//     );
//     boundaries.add(
//       Boundary(
//           position: Vector2(0, size[1] - 1),
//           size: Vector2(size[0], 10),
//           boundarySprite: await Sprite.load('wall.png'),
//           isBottom: true),
//     );
//     boundaries.add(
//       Boundary(
//         position: Vector2(size[0] - 1, size[1]),
//         size: Vector2(10, size[1]),
//         boundarySprite: await Sprite.load('wall.png'),
//       ),
//     );
//     List<List<Brick>> brickLayer = [];
//     List<Brick> bricks1 = [];
//     List<Brick> bricks2 = [];
//     List<Brick> bricks3 = [];
//     List<Brick> bricks4 = [];

//     List.generate(size[0] ~/ 80, (index) async {
//       var random = Random().nextInt(4);
//       if (index % 2 == 0) {
//         bricks1.add(
//           Brick(
//             brickSprite: await Sprite.load('tile${random + 1}.png'),
//             brickPosition: Vector2(index * 80, 0),
//           ),
//         );
//       }
//     });
//     List.generate(size[0] ~/ 80, (index) async {
//       var random = Random().nextInt(4);
//       if (true) {
//         {
//           bricks2.add(
//             Brick(
//               brickSprite: await Sprite.load('tile${random + 1}.png'),
//               brickPosition: Vector2(index * 80, 40),
//             ),
//           );
//         }
//       }
//     });
//     List.generate(size[0] ~/ 80, (index) async {
//       var random = Random().nextInt(4);
//       if (index % 2 == 0) {
//         {
//           bricks3.add(
//             Brick(
//               brickSprite: await Sprite.load('tile${random + 1}.png'),
//               brickPosition: Vector2(index * 80, 80),
//             ),
//           );
//         }
//       }
//     });
//     List.generate(size[0] ~/ 80, (index) async {
//       var random = Random().nextInt(4);
//       bricks4.add(
//         Brick(
//           brickSprite: await Sprite.load('tile${random + 1}.png'),
//           brickPosition: Vector2(index * 80, 120),
//         ),
//       );
//     });
//     brickLayer.addAll([bricks1, bricks2, bricks3, bricks4]);
//     currentScore = TextComponent(
//       text: score.toString(),
//       position: Vector2(size[0] / 2 - 10, 10),
//     );
//     player = Player(
//       playerSprite: await Sprite.load('player.png'),
//       playerSize: size,
//       speed: 10,
//     );
//     await add(player);
//     await add(ball);
//     for (var element in brickLayer) {
//       addAll(element);
//     }
//     await addAll(boundaries);
//     return super.onLoad();
//   }

//   @override
//   void update(double dt) {
//     // if (player.position.x < 0) {
//     //   player.position.x = 0;
//     // } else if (player.position.x > size[0] - player.size[0]) {
//     //   player.position.x = size.x - player.size.x;
//     // }
//     ball.update(dt);
//     player.update(dt);
//     super.update(dt);
//   }
// }
