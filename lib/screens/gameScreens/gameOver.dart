import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:rive/rive.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/constants/animation_constant.dart';
import 'package:team_vibrant_breakout/screens/gameLevels.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/game.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/game_page.dart';
import 'package:team_vibrant_breakout/screens/starterPage.dart';

class GameOver extends StatelessWidget {
  GameOver({super.key});

  static var myfont = GoogleFonts.pressStart2p;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(color: colorBlack),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: titleAnimationTag,
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: 16,
                                  color: shadowColor,
                                  style: BorderStyle.solid),
                              left: BorderSide(width: 16, color: shadowColor),
                              bottom: const BorderSide(
                                  width: 16,
                                  color: Colors.black87,
                                  style: BorderStyle.solid),
                              right: const BorderSide(
                                  width: 16,
                                  color: Colors.black87,
                                  style: BorderStyle.solid))),
                      child: BounceInDown(
                        delay: const Duration(milliseconds: 6),
                        child: Text(
                          'GAME OVER',
                          textAlign: TextAlign.center,
                          style: myfont(
                            textStyle: const TextStyle(
                              letterSpacing: 20,
                              color: buttonColor,
                              fontSize: 23,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                ),
              ),
              //const Spacer()
              const SizedBox(
                height: 80,
              ),
              BounceInUp(
                child: GameScreenButton(
                  onTap: () {
                    Get.off(() => GamePage(brickGame: BrickGame(),));
                  },
                  label: 'Play Again',
                ),
                  //const Spacer()
                  const SizedBox(height: 80),
                  BounceInLeft(
                    child: GameScreenButton(
                      onTap: () {
                        Get.off(() => GamePage(
                              brickGame: BrickGame(),
                            ));
                      },
                      label: 'Play Again',
                    ),
                  ),
                  const SizedBox(height: 20),
                  BounceInRight(
                    child: GameScreenButton(
                      onTap: () {
                        Get.offUntil(
                          MaterialPageRoute(
                            builder: (context) => const StarterPage(),
                          ),
                          (route) => false,
                        );
                      },
                      label: 'Home',
                    ),
                  ),
                ],

              ),
            ),
          ),
        ),
      ),
    );
  }
}
