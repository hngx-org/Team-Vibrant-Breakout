import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:team_vibrant_breakout/screens/authScreens/signup.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
          child: Center(child: Text('Lets get started')),
          onPressed: () {
            Get.to(() => SignUpScreen());
          }),
    );
  }
}
