import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/constants/animation_constant.dart';
import 'package:team_vibrant_breakout/screens/gameScreen.dart';
import 'package:team_vibrant_breakout/screens/starterPage.dart';

// class SplashPage extends StatelessWidget {
//   const SplashPage({super.key});

//   @override
//   Widget build(BuildContext context) {
// return FutureBuilder(
//   future: Future.delayed(
//     const Duration(seconds: 3),
//     () => Get.to(const MainPage()),
//   ),
//   builder: (context, snapshot) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: bgColorGradient,
//         ),
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             SizedBox(height: 20),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.3,
//               child: LinearProgressIndicator(
//                 minHeight: 30,
//                 color: textColor,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   },
// );
//   }
// }

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 4), () => Get.to(StarterPage())),
      builder: (context, snapshot) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/image1.jpeg"), fit: BoxFit.fill)),
            width: double.maxFinite,
            height: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
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
                              color: textColor,
                              style: BorderStyle.solid),
                          right: BorderSide(
                              width: 16,
                              color: textColor,
                              style: BorderStyle.solid))),
                  child: Text(
                    'BREAKOUT GAME',
                    style: TextStyle(
                        backgroundColor: buttonColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 35,
                        color: colorBlack),
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
