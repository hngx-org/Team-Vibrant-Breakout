import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/screens/settingPage.dart';
import 'package:team_vibrant_breakout/screens/starterPage.dart';

import '../constants/controllers.dart';

class GameToolBar extends StatefulWidget {
  GameToolBar({
    super.key,
    required this.onSettingsTap,
    required this.onPause,
    required this.onResume,
    required this.onRestart,
  });

  final VoidCallback onSettingsTap;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onRestart;

  @override
  State<GameToolBar> createState() => _GameToolBarState();
}

class _GameToolBarState extends State<GameToolBar> {
  int score = 0;
  bool isPaused = false;
  SharedPreferences? _prefs;

  late ScoreController scoreController;

  @override
  void initState() {
    super.initState();
    _loadScore();
    scoreController = Get.put(ScoreController());
  }

  void togglePauseUponPress() {
    setState(() {
      isPaused ? widget.onResume() : widget.onPause();
      isPaused = !isPaused;
    });
  }

// load score from Shared preferences
  _loadScore() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      score = _prefs?.getInt('score') ?? 0;
    });
  }

  // save the score to SharedPreferences

  _saveScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('score', score);
  }

  // Increase Score and Save to SharedPreferences
  void increaseScore() {
    setState(() {
      score += 10;
      _saveScore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 188, 99, 204),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                isPaused = true;
                widget.onRestart();
              });
              Get.to(() => const RestartWidget());
            },
            icon: Icon(
              Icons.restart_alt_sharp,
              color: buttonColor,
              size: 40,
            ),
          ),

          IconButton(
            onPressed: () {
              setState(() {
                isPaused = true;
                widget.onSettingsTap();
              });
              Get.to(() => const SettingsDialog());
            },
            icon: Icon(
              Icons.settings_applications,
              color: buttonColor,
              size: 40,
            ),
          ),
          Obx(
            () => Text(
              'Score: ${scoreController.score.value}',
              style: TextStyle(fontSize: 30, color: buttonColor),
            ),
          ),

          IconButton(
            onPressed: togglePauseUponPress,
            icon: Icon(
              !isPaused ? Icons.pause_circle : Icons.play_circle_fill,
              color: buttonColor,
              size: 40,
            ),
          ),

          // IconButton(
          //     onPressed: null,
          //     icon: Icon(
          //       Icons.music_off,
          //       color: shadowColor,
          //       size: 40,
          //     ))
        ],
      ),
    );
  }
}
