import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
//import 'package:rive/rive.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/constants/animation_constant.dart';
import 'package:team_vibrant_breakout/screens/gameLevels.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/game_page.dart';

class StarterPage extends StatelessWidget {
  const StarterPage({super.key});

  static var myfont = GoogleFonts.pressStart2p;

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
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'HighScore: 0000',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: buttonColor),
                  ),
                ],
              ),
              const Spacer(),
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
                      style: myfont(
                          textStyle: TextStyle(
                        color: buttonColor,
                        fontSize: 25,
                      )),
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
                    Get.to(const GamePage());
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
                    Get.dialog(
                      GameLevels(),
                    );
                  },
                  label: 'Levels',
                ),
              ),
              const SizedBox(height: 10),
              // GameScreenButton(
              //   onTap: () {
              //     Get.dialog(
              //       SettingsDialog(),
              //     );
              //   },
              //   label: 'Settings',
              // ),
              //const SizedBox(height: 10),
              BounceInLeft(
                child: GameScreenButton(
                  onTap: () {
                    Get.dialog(
                      CustomDialogWidget(),
                    );
                  },
                  label: 'Exit',
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
        color: buttonColor,
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
        constraints: const BoxConstraints(
          maxHeight: 300,
        ),
        color: buttonColor,
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
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
