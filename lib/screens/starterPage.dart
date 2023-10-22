import 'package:animate_do/animate_do.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
//import 'package:rive/rive.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/authentication/authController.dart';
import 'package:team_vibrant_breakout/constants/animation_constant.dart';
import 'package:team_vibrant_breakout/screens/authScreens/login.dart';
import 'package:team_vibrant_breakout/screens/gameLevels.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/game.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/game_page.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/how_to_play.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/leaderboard.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/level4.dart';

class StarterPage extends StatelessWidget {
  StarterPage({super.key});

  // static var myfont = GoogleFonts.pressStart2p
  String? displayName = AuthController.instance.getDisplayName();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/image2.jpeg"), fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 70, right: 10.0),
                  ),
                  if (displayName != null)
                    BounceInDown(
                      delay: Duration(milliseconds: 50),
                      child: Text(
                        'Welcome, $displayName!', // Display the user's name here
                        style: TextStyle(
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            fontFamily: "DRAGON",
                            color: buttonColor),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 30),
              Hero(
                tag: titleAnimationTag,
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 16,
                              color: shadowColor,
                              style: BorderStyle.solid),
                          left: BorderSide(width: 16, color: shadowColor),
                          bottom: BorderSide(
                              width: 16,
                              color: Colors.black87,
                              style: BorderStyle.solid),
                          right: BorderSide(
                              width: 16,
                              color: Colors.black87,
                              style: BorderStyle.solid))),
                  child: BounceInLeft(
                    delay: Duration(milliseconds: 6),
                    child: Text(
                      'Retro Breakout',
                      style: TextStyle(
                          letterSpacing: 7,
                          color: buttonColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'ARCADECLASSIC'),
                    ),
                  ),
                ),
              ),
              //const Spacer()
              const SizedBox(
                height: 80,
              ),
              BounceInLeft(
                child: GameScreenButton(
                  onTap: () {
                    Get.to(() => const GameLevels());
                  },
                  label: 'Play',
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BounceInLeft(
                child: GameScreenButton(
                  onTap: () {
                    Get.to(LeaderboardPage());
                  },
                  label: 'LeaderBoard',
                ),
              ),

              // GameScreenButton(
              //   onTap: () {
              //     Get.dialog(
              //       SettingsDialog(),
              //     );
              //   },
              //   label: 'Settings',
              // ),
              const SizedBox(height: 10),
              BounceInLeft(
                child: GameScreenButton(
                  onTap: () {
                    Get.to(InstructionsScreen());
                  },
                  label: 'How to Play',
                ),
              ),
              const SizedBox(height: 10),
              BounceInLeft(
                child: GameScreenButton(
                  onTap: () {
                    AuthController.instance.logOut();
                    Get.offAll(() => LoginScreen());
                  },
                  label: 'LOG OUT',
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.6,
        constraints: const BoxConstraints(maxHeight: 500, maxWidth: 500),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      iconSize: 30,
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomSettingsSlider(
              label: 'Music',
            ),
            const SizedBox(height: 20),
            CustomSettingsSlider(
              label: 'Sfx',
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class CustomSettingsSlider extends StatelessWidget {
  const CustomSettingsSlider({
    super.key,
    required this.label,
  });
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Slider.adaptive(
          value: 3,
          max: 5,
          min: 1,
          divisions: 5,
          onChanged: (value) {},
          thumbColor: borderSideColor,
          inactiveColor: Colors.brown,
          activeColor: Colors.red,
        )
      ],
    );
  }
}

class CustomDialogWidget extends StatelessWidget {
  const CustomDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.5,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20),
        ),
        constraints: const BoxConstraints(
          maxHeight: 300,
        ),
        child: Column(
          children: [
            const Spacer(),
            Text('Are you sure you want to exit?'),
            const Spacer(),
            ButtonBar(
              children: [
                MaterialButton(
                  height: 50,
                  onPressed: () {},
                  child: const Text('Yes'),
                ),
                MaterialButton(
                  color: Colors.black,
                  height: 50,
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('No'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class GameScreenButton extends StatelessWidget {
  const GameScreenButton({
    super.key,
    required this.label,
    required this.onTap,
  });
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: MediaQuery.of(context).size.width * 0.4,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: const BorderSide(
          color: borderSideColor,
        ),
      ),
      height: 60,
      onPressed: onTap,
      color: buttonColor,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          fontFamily: 'DRAGON',
        ),
      ),
    );
  }
}

class RestartWidget extends StatelessWidget {
  const RestartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.5,
        constraints: const BoxConstraints(
          maxHeight: 300,
        ),
        color: buttonColor,
        child: Column(
          children: [
            const Spacer(),
            Text('Are you sure you want to quit?'),
            Text('you will lose your progress'),
            const Spacer(),
            ButtonBar(
              children: [
                MaterialButton(
                  height: 50,
                  onPressed: () {
                    Get.offAll(() => GamePage(brickGame: BrickGame()));
                  },
                  child: const Text('Yes'),
                ),
                MaterialButton(
                  color: Colors.black,
                  height: 50,
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('No'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
