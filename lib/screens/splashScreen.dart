import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/constants/animation_constant.dart';
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
      future: Future.delayed(
        const Duration(seconds: 3),
        () => Get.to(const StarterPage()),
      ),
      builder: (context, snapshot) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: bgColor,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'BREAK OUT GAME',
                  style: TextStyle(fontSize: 40, color: textColor),
                ),

                SizedBox(
                  height: 20,
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.3,
                //   child: LinearProgressIndicator(
                //     minHeight: 30,
                //     color: colorBlack,
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
