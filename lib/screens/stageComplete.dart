import 'package:animate_do/animate_do.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:rive/rive.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/constants/animation_constant.dart';
import 'package:team_vibrant_breakout/constants/controllers.dart';

import 'package:team_vibrant_breakout/screens/gameScreens/game_page.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/level2.dart';
import 'package:team_vibrant_breakout/screens/starterPage.dart';

import 'gameScreens/components/confetti.dart';

class LevelComplete extends StatefulWidget {
  LevelComplete({super.key});

  @override
  State<LevelComplete> createState() => _LevelCompleteState();
}

class _LevelCompleteState extends State<LevelComplete> {
  final dynamic confettiController = ConfettiController();

  @override
  void initState() {
    super.initState();
    confettiController.play();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }
  // static var myfont = GoogleFonts.pressStart2p;

  @override
  Widget build(BuildContext context) {
    ScoreController scoreController = Get.put(ScoreController());
    scoreController.nextLevel();
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(color: colorBlack),
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              MyConfetti(controller: confettiController),

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
                      'CONGRATIONS',
                      style: TextStyle(
                          letterSpacing: 10,
                          color: buttonColor,
                          fontSize: 25,
                          fontFamily: 'ARCADECLASSIC'),
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
                    print(scoreController.selectedLevelIndex);
                    print(scoreController.allLevels.length);

                    if (scoreController.selectedLevelIndex >=
                        scoreController.allLevels.length) {
                      Get.snackbar(
                        'Ongoing',
                        'We are still in the process of making this. please hold up a moment',
                        margin: const EdgeInsets.symmetric(
                          vertical: 30,
                          horizontal: 20,
                        ),
                        backgroundColor: Colors.brown.withOpacity(.5),
                      );
                    } else {
                      Get.off(
                        () => GamePage(
                          brickGame: scoreController
                              .allLevels[scoreController.selectedLevelIndex],
                        ),
                      );
                    }
                  },
                  label: 'Next Level',
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              BounceInUp(
                child: GameScreenButton(
                  onTap: () {
                    Get.off(() => StarterPage());
                  },
                  label: 'Home',
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class DialogueBox extends StatefulWidget {
  const DialogueBox(
      {Key? key,
      required this.dialogIcon,
      required this.dialogText,
      required this.dialogButton})
      : super(key: key);

  final Widget dialogIcon, dialogText, dialogButton;

  @override
  State<DialogueBox> createState() => _DialogueBoxState();
}

class _DialogueBoxState extends State<DialogueBox> {
  final dynamic confettiController = ConfettiController();

  @override
  void initState() {
    super.initState();
    confettiController.play();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.zero,
      child: Container(
        height: 428.h,
        width: 380.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Color(0xFFFFDB58)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyConfetti(controller: confettiController),
            widget.dialogIcon,
            SizedBox(
              height: 32.h,
            ),
            widget.dialogText,
            SizedBox(
              height: 64.h,
            ),
            widget.dialogButton
          ],
        ),
      ),
    );
  }
}
