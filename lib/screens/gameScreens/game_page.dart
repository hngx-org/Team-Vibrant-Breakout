import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/brick_game_base_class.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/game.dart';
import 'package:team_vibrant_breakout/screens/gametoolBar.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.brickGame});

  final BrickGameBaseClass brickGame;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late BrickGameBaseClass game;

  @override
  void initState() {
    game = widget.brickGame;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GameToolBar(
            onPause: () => game.paused = true,
            onResume: () => game.paused = false,
            onSettingsTap: () => game.paused = true,
            onRestart: () => game.paused = true,
          ),
          Expanded(
            child: GameWidget(
              game: game,
            ),
          ),
        ],
      ),
    );
  }
}
