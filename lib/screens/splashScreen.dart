import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/constants/animation_constant.dart';
import 'package:team_vibrant_breakout/screens/starterPage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static var myfont = GoogleFonts.pressStart2p;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 4), () => Get.to(StarterPage())),
      builder: (context, snapshot) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/image1.jpeg"), fit: BoxFit.fill)),
            width: double.maxFinite,
            height: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                FadeInLeftBig(
                  delay: Duration(milliseconds: 3),
                  //duration: Duration(milliseconds: 6),
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
                    child: Text(
                      'BREAKOUT GAME',
                      style: myfont(
                          textStyle: TextStyle(
                        color: buttonColor,
                        fontSize: 22,
                      )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: LinearProgressIndicator(
                    minHeight: 30,
                    color: bgColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
