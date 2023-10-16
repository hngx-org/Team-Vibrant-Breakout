import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/constants/animation_constant.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/game.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/game_page.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/level2.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/level3.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/level4.dart';

class GameLevels extends StatelessWidget {
  const GameLevels({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: bgColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                  color: colorWhite,
                  iconSize: 30,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.black,
                centerTitle: true,
                title: const Hero(
                  tag: titleAnimationTag,
                  child: Text(
                    'Select Level',
                    style: TextStyle(
                      color: colorWhite,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                ),
                child: Wrap(
                  children: List.generate(
                    6,
                    (index) => Padding(
                      padding: const EdgeInsets.all(3),
                      child: LevelContainer(
                        onPressed: () {
                          switch (index) {
                            case 0:
                              Get.to(() => GamePage(brickGame: BrickGame()));
                              break;
                            case 1:
                              Get.to(() => GamePage(brickGame: Level2()));
                              break;
                            case 2:
                              Get.to(() => GamePage(brickGame: Level3()));
                              break;
                            case 3:
                              Get.to(() => GamePage(brickGame: Level4()));
                              break;
                            default:
                              Get.snackbar(
                                'Ongoing',
                                'We are still in the process of making this. please hold up a moment',
                                margin: const EdgeInsets.symmetric(
                                  vertical: 30,
                                  horizontal: 20,
                                ),
                                backgroundColor: Colors.brown.withOpacity(.5),
                              );
                          }
                        },
                        levelNumber: index,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LevelContainer extends StatelessWidget {
  const LevelContainer({
    super.key,
    required this.levelNumber,
    required this.onPressed,
  });

  final int levelNumber;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        height: MediaQuery.of(context).size.width * 0.3,
        constraints: const BoxConstraints(maxHeight: 100, maxWidth: 100),
        decoration: BoxDecoration(
          color: levelsColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white12,
          ),
        ),
        child: Center(
          child: Text(
            levelNumber.toString(),
            style: const TextStyle(
              fontSize: 30,
              color: colorBlack,
            ),
          ),
        ),
      ),
    );
  }
}
