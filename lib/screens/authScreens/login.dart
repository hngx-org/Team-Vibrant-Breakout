import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/authentication/authController.dart';
import 'package:team_vibrant_breakout/screens/authScreens/authScreenWidgets.dart';
import 'package:team_vibrant_breakout/screens/authScreens/loadingWidget.dart';
import 'package:team_vibrant_breakout/screens/authScreens/signup.dart';
import 'package:team_vibrant_breakout/screens/starterPage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  //UserController userController = Get.put(UserController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _passwordVisible;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("images/image2.jpeg"), fit: BoxFit.fill),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                      // color: Colors.black
                      //     .withOpacity(0.7), // Adjust the opacity as needed
                      ),
                ),
                const SizedBox(
                  height: 200,
                ),
                const RetroText(
                  largeText: "Retro Breakout",
                  smallText: "Login To Your Account",
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      InfoFilelds(
                        hintText: 'Enter your email',
                        icon: const Icon(Icons.email),
                        validator: (value) {
                          if (value != null && value.isEmail) {
                            return null;
                          } else {
                            return 'input a valid email address';
                          }
                        },
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InfoFilelds(
                        obscureText: !_passwordVisible,
                        hintText: "Enter your password",
                        controller: passwordController,
                        validator: (value) {
                          if (value != null && value.length >= 6) {
                            return null;
                          } else if (value == null) {
                            return 'input valid password';
                          } else {
                            return 'password should be at least 6 characters long';
                          }
                        },
                        icon: const Icon(Icons.lock),
                        trailing: IconButton(
                          icon: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                AuthScreenButtons(
                    text: 'Login',
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        {
                          final result = await loadToScreen(
                            asyncComputation: () async =>
                                AuthController.instance.login(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            ),
                            context: context,
                          );

                          // After successful login, update Hive
                          Box userBox = await Hive.openBox('userBox');
                          userBox.put('isLoggedIn', true);
                          Get.offAll(() => StarterPage());
                          // if (result == null) {
                          //   Get.to(() => const StarterPage());
                          // } else {
                          //   Get.snackbar(
                          //     'Authentication Error',
                          //     "User unable to login",
                          //     colorText: Colors.red,
                          //     margin: const EdgeInsets.all(10),
                          //     duration: const Duration(seconds: 3),
                          //   );
                          // }
                        }
                      }
                    }),
                const SizedBox(
                  height: 100,
                ),
                InLineTexts(
                  firstText: 'Dont have an account?',
                  secondText: 'Sign Up',
                  onpressed: () => Get.to(
                    () => const SignUpScreen(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
    //]),
    // );
  }
}
