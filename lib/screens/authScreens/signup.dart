import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/authentication/authController.dart';
//import 'package:team_vibrant_breakout/authentication/authController.dart';
import 'package:team_vibrant_breakout/screens/authScreens/authScreenWidgets.dart';
import 'package:team_vibrant_breakout/screens/authScreens/loadingWidget.dart';
import 'package:team_vibrant_breakout/screens/authScreens/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePassword = false;
  bool _obscurePassword2 = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController nameController = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _obscurePassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      //Set the background color to be transparent
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/image2.jpeg"),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Use a BackdropFilter to blur the background
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                    child: Container(
                      color: Colors.black
                          .withOpacity(0.3), // Adjust the opacity as needed
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  RetroText(
                    largeText: "Retro Breakout",
                    smallText: "Register an Account",
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        InfoFilelds(
                          hintText: 'Enter your Name',
                          icon: Icon(Icons.person),
                          validator: (value) {
                            if (value != null && value.length > 3) {
                              return null;
                            } else if (value == null) {
                              return 'input valid name';
                            } else {
                              return 'names should be at least 3 characters long';
                            }
                          },
                          controller: nameController,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InfoFilelds(
                          hintText: "Enter your Email Address",
                          icon: Icon(Icons.email),
                          controller: emailController,
                          validator: (value) {
                            if (value != null && value.isEmail) {
                              return null;
                            } else {
                              return 'input a valid email address';
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InfoFilelds(
                          obscureText: !_obscurePassword2,
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
                          icon: Icon(Icons.lock),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword2 = !_obscurePassword2;
                              });
                            },
                            icon: Icon(_obscurePassword2
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        InfoFilelds(
                          obscureText: !_obscurePassword,
                          hintText: "Enter your password",
                          controller: passwordController2,
                          validator: (value) {
                            if (value != null && value.length >= 6) {
                              return null;
                            } else if (value == null) {
                              return 'input valid password';
                            } else {
                              return 'password should be at least 6 characters long';
                            }
                          },
                          icon: Icon(Icons.lock),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(_obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  AuthScreenButtons(
                      text: 'Create Account',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          {
                            final result = await loadToScreen(
                              asyncComputation: () async =>
                                  AuthController.instance.register(
                                nameController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              ),
                              context: context,
                            );
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
                  SizedBox(
                    height: 60,
                  ),
                  InLineTexts(
                    firstText: 'Already have an account?',
                    secondText: 'Login',
                    onpressed: () => Get.to(
                      () => const LoginScreen(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
