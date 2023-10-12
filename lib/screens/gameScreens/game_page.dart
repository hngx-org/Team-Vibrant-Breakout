import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/game.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  BrickGame game = BrickGame();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: game,
      ),
    );
  }
}
