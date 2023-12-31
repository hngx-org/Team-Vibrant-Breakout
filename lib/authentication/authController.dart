import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';
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
    // ever(_user, _initialScreen);
  }

  // _initialScreen(User? user) {
  //   if (user != null) {
  //     print('User is logged in');
  //     Get.offAll(StarterPage());
  //   }
  //   // No need to handle the case where user is null (not logged in) here.
  //   // This will allow the screen state to update without redirection.
  // }
  void handleAuthentication() {
    if (AuthController.instance.auth.currentUser != null) {
      // User is logged in, navigate to StarterPage
      Get.offAll(() => StarterPage());
    } else {
      // User is not logged in, navigate to LoginScreen
      Get.offAll(() => LoginScreen());
    }
  }

  String? getDisplayName() {
    return _user.value?.displayName;
  }

//create account/register
  void register(String name, email, password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // ignore: deprecated_member_use
      await userCredential.user!.updateProfile(displayName: name);
      // await auth.createUserWithEmailAndPassword(
      //     email: email, password: password);
      Get.to(() => StarterPage());
    } on FirebaseAuthException catch (e) {
      if (e.message == 'weak-password') {
        // print('No user found for that email.');
        Get.snackbar('Account Creation Failed', 'Registration Message',
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
              'Password is too weak',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
            messageText: Text(
              e.message!,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w400),
            ));
      } else if (e.message == 'email-already-in-use') {
        // print('Wrong password provided for that user.');
        Get.snackbar('Account Creation Failed', 'Registration Message',
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
              'An account for that email already exists',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
            messageText: Text(
              e.message!,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w400),
            ));
      } else {
        Get.snackbar(
          'Error',
          'Loading error',
          snackPosition: SnackPosition.TOP,
          backgroundColor: colorWhite,
          titleText: Text(
            'Error',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
          messageText: Text(
            e.message!,
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.w400),
          ),
        );
      }

      // if (e.code == 'weak-password') {
      //   print('The password provided is too weak.');
      // } else if (e.code == 'email-already-in-use') {
      //   print('The account already exists for that email.');
      // } else {
      //   print(e);
      // }
    }
  }

  //LOGIN
  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.to(() => StarterPage());
    } on FirebaseAuthException catch (e) {
      if (e.message == 'user-not-found') {
        // print('No user found for that email.');
        Get.snackbar('Login Failed', 'Login Message',
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
              'No user found',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
            messageText: Text(
              e.message!,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w400),
            ));
      } else if (e.message == 'wrong-password') {
        // print('Wrong password provided for that user.');
        Get.snackbar('Wrong Password', 'Login Failed',
            snackPosition: SnackPosition.BOTTOM,
            titleText: Text(
              'wrong password',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
            ),
            messageText: Text(
              e.message!,
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.w400),
            ));
      } else {
        Get.snackbar(
          'Error',
          'Loading error',
          snackPosition: SnackPosition.TOP,
          backgroundColor: colorWhite,
          titleText: Text(
            'Error',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
          ),
          messageText: Text(
            e.message!,
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.w400),
          ),
        );
      }
    }
  }

  void logOut() async {
    await auth.signOut();
  }

//   Future<void> saveScore(String playerName, int score) async {
//   var user = FirebaseAuth.instance.currentUser;

//   if (user != null) {
//     try {
//       await FirebaseFirestore.instance
//           .collection('user_scores')
//           .doc(user.uid)
//           .set({
//         'name': playerName,
//         'score': score,
//       });
//       print('Score saved successfully!');
//     } catch (e) {
//       print('Error saving score: $e');
//     }
//   }
// }
}
