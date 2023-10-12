import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/screens/settingPage.dart';
import 'package:team_vibrant_breakout/screens/starterPage.dart';

class GameToolBar extends StatefulWidget {
  const GameToolBar(
      {super.key,
      required this.onSettingsTap,
      required this.onPause,
      required this.onResume});

  final VoidCallback onSettingsTap;
  final VoidCallback onPause;
  final VoidCallback onResume;

  @override
  State<GameToolBar> createState() => _GameToolBarState();
}

class _GameToolBarState extends State<GameToolBar> {
  bool isPaused = false;

  void togglePauseUponPress() {
    setState(() {
      isPaused ? widget.onResume() : widget.onPause();
      isPaused = !isPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
            color: shadowColor,
            size: 40,
          ),
        ),
        Text(
          'Score: 900',
          style: TextStyle(fontSize: 30, color: shadowColor),
        ),

        IconButton(
          onPressed: togglePauseUponPress,
          icon: Icon(
            !isPaused ? Icons.pause_circle : Icons.play_circle_fill,
            color: shadowColor,
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
    );
  }
}
