import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:team_vibrant_breakout/screens/authScreens/actualSplashScreen.dart';
import 'package:team_vibrant_breakout/screens/authScreens/login.dart';
import 'package:team_vibrant_breakout/screens/authScreens/signup.dart';
import 'package:team_vibrant_breakout/screens/splashScreen.dart';
import 'package:team_vibrant_breakout/screens/starterPage.dart';

class AuthController extends GetxController {
  //AuthController.instance..
  static AuthController instance = Get.find();
  //email,password, name
  late Rx<User?> _user;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();

    _user = Rx<User?>(auth.currentUser);
//notifies user upon any changes
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print('loginpage');
      Get.offAll(() => SignUpScreen());
    } else {
      //take note
      Get.offAll(StarterPage(
          // email: user.email!
          ));
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar('About User', 'User Message',
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Account Registration failed",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w400),
          ));
    }
  }

  //LOGIN
  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar('About Login', 'Login Message',
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "LogIn failed",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
          messageText: Text(
            e.toString(),
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w400),
          ));
    }
  }

  void logOut() async {
    await auth.signOut();
  }
}
