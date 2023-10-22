import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:rive/rive.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/authentication/authController.dart';
import 'package:team_vibrant_breakout/constants/adapter/userController.dart';
import 'package:team_vibrant_breakout/constants/animation_constant.dart';
import 'package:team_vibrant_breakout/screens/gameLevels.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/game.dart';
import 'package:team_vibrant_breakout/screens/gameScreens/game_page.dart';
import 'package:team_vibrant_breakout/screens/starterPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/controllers.dart';

class GameOver extends StatelessWidget {
  GameOver({super.key});

  // static var myfont = GoogleFonts.pressStart2p;
  final ScoreController scoreController = Get.put(ScoreController());
  // final UserController userController = Get.put(UserController());
  final nameController = TextEditingController();

  void _submitScore() {
    String displayName =
        AuthController.instance.getDisplayName() ?? 'Anonymous';
    int score = scoreController.score.value;

    FirebaseFirestore.instance.collection('highScores').add({
      'name': displayName,
      'score': score,
    }).then((value) {
      Get.snackbar(
        'Success',
        'Your score has been submitted successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: buttonColor.withOpacity(.8),
        colorText: Colors.black,
      );

      print("Score added to Firestore!");
    }).catchError((error) {
      Get.snackbar(
        'Error',
        'An error occurred while submitting your score.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(.4),
        colorText: Colors.white,
      );
      print("Failed to add score: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                            style: TextStyle(
                                letterSpacing: 12,
                                color: buttonColor,
                                fontSize: 30,
                                fontFamily: 'ARCADECLASSIC'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),

                    Text(
                      'Score: ${scoreController.score}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'ARCADECLASSIC',
                      ),
                    ),
                    //const Spacer()
                    const SizedBox(height: 80),
                    BounceInLeft(
                      child: GameScreenButton(
                        onTap: () {
                          Get.back();
                        },
                        label: 'Play Again',
                      ),
                    ),
                    const SizedBox(height: 20),
                    BounceInLeft(
                      child: GameScreenButton(
                        onTap: () {
                          _submitScore();
                        },
                        label: 'Submit Score',
                      ),
                    ),

                    // showDialog(
                    //   context: context,
                    //   barrierDismissible: false,
                    //   builder: (context) {
                    //     return Dialog(
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(16),
                    //       ),
                    //       child: Container(
                    //         width: MediaQuery.of(context).size.width,
                    //         height:
                    //             MediaQuery.of(context).size.height * 0.3,
                    //         constraints: const BoxConstraints(
                    //             maxHeight: 500, maxWidth: 500),
                    //         color: buttonColor,
                    //         child: Column(
                    //           mainAxisSize: MainAxisSize.min,
                    //           children: [
                    //             Text(
                    //               'Submit Your Score',
                    //               style: TextStyle(
                    //                 fontFamily: 'ARCADECLASSIC',
                    //                 fontSize: 20,
                    //               ),
                    //             ),
                    //             SizedBox(height: 8),
                    //             Text(
                    //               'Your score is ${scoreController.score}',
                    //               style: TextStyle(
                    //                 fontFamily: 'ARCADECLASSIC',
                    //                 fontSize: 16,
                    //               ),
                    //             ),
                    //             SizedBox(height: 8),
                    //             TextField(
                    //               controller: nameController,
                    //               decoration: InputDecoration(
                    //                 hintText: 'Enter name',
                    //                 contentPadding: EdgeInsets.all(10),
                    //               ),
                    //             ),
                    //             Spacer(),
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceAround,
                    //               children: [
                    //                 ClipRRect(
                    //                   borderRadius:
                    //                       BorderRadius.circular(20),
                    //                   child: MaterialButton(
                    //                     onPressed: () {
                    //                       Navigator.pop(context);
                    //                     },
                    //                     child: Text('Cancel'),
                    //                     color: buttonColor,
                    //                   ),
                    //                 ),
                    //                 ClipRRect(
                    //                   borderRadius:
                    //                       BorderRadius.circular(20),
                    //                   child: MaterialButton(
                    //                     onPressed: () {
                    //                       Navigator.pop(context);
                    //                       submitScore();
                    //                     },
                    //                     child: Text(
                    //                       'Submit',
                    //                       style: TextStyle(
                    //                           color: Colors.white),
                    //                     ),
                    //                     color: Colors.black,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //             const SizedBox(height: 10),
                    //           ],
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // );
                    //     },
                    //     label: 'Submit Score',
                    //   ),
                    // ),

                    const SizedBox(height: 20),
                    BounceInRight(
                      child: GameScreenButton(
                        onTap: () {
                          Get.offUntil(
                            MaterialPageRoute(
                              builder: (context) => StarterPage(),
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
      ),
    );
  }
}
