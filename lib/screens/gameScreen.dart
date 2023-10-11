import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/constants/animation_constant.dart';
import 'package:team_vibrant_breakout/widgets/ball.dart';
import 'package:team_vibrant_breakout/widgets/coverScreen.dart';
import 'package:team_vibrant_breakout/widgets/player.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  double xBall = 0;
  double yBall = 0;

//game settings
  bool hasGameBegan = false;

  //variables for player
  double xPlayer = 0;
  double playerWidth = 0.5;

  void beginGame() {
    hasGameBegan = true;
    Timer.periodic(Duration(milliseconds: 15), (timer) {
      setState(() {
        yBall -= 0.01;
      });
    });
  }

  //move the player left
  void moveLeft() {
    setState(() {
      xPlayer -= 0.2;
    });
  }

  //move the player right
  void moveRight() {
    setState(() {
      xPlayer += 0.2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (RawKeyEvent event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: beginGame,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: bgColor,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: colorWhite,
              ),
              onPressed: Navigator.of(context).pop,
            ),
          ),
          backgroundColor: bgColor,
          body: Center(
            child: Stack(
              children: [
                //tap to play
                CoverScreen(
                  hasGameBegan: hasGameBegan,
                ),
                //ball

                MyBall(xBall: xBall, yBall: yBall),

                //player
                Player(xPlayer: xPlayer, playerWidth: playerWidth)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
