import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/authentication/authController.dart';
//import 'package:team_vibrant_breakout/authentication/authController.dart';
import 'package:team_vibrant_breakout/screens/authScreens/authScreenWidgets.dart';
import 'package:team_vibrant_breakout/screens/authScreens/login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

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
  //UserController userController = Get.put(UserController());
  // final messageController = Get.put(MessageController());
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _obscurePassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
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
                    const SizedBox(
                      height: 100,
                    ),
                    const RetroText(
                      largeText: "Retro Breakout",
                      smallText: "Register an Account",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InfoFilelds(
                            hintText: 'Enter your Name',
                            icon: const Icon(Icons.person),
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
                          const SizedBox(
                            height: 30,
                          ),
                          InfoFilelds(
                            hintText: "Enter your Email Address",
                            icon: const Icon(Icons.email),
                            controller: emailController,
                            validator: (value) {
                              if (value != null && value.isEmail) {
                                return null;
                              } else {
                                return 'input a valid email address';
                              }
                            },
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InfoFilelds(
                            obscureText: !_obscurePassword,
                            hintText: "Enter your password",
                            controller: passwordController,
                            validator: (value) {
                              if (value != null && value.length >= 8) {
                                return null;
                              } else if (value == null) {
                                return 'input valid password';
                              } else {
                                return 'password should be at least 8 characters long';
                              }
                            },
                            icon: const Icon(Icons.lock),
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
                          const SizedBox(
                            height: 30,
                          ),
                          InfoFilelds(
                            obscureText: !_obscurePassword,
                            hintText: "Enter your password",
                            controller: passwordController2,
                            validator: (value) {
                              if (value != null && value.length >= 8) {
                                return null;
                              } else if (value == null) {
                                return 'input valid password';
                              } else {
                                return 'password should be at least 8 characters long';
                              }
                            },
                            icon: const Icon(Icons.lock),
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
                    const SizedBox(height: 30),
                    AuthScreenButtons(
                      onTap: () {
                        AuthController.instance.register(
                            nameController.text.trim(),
                            emailController.text.trim(),
                            passwordController.text.trim());
                        //Get.to(() => const LoginScreen());
                      },
                      text: 'Create Account',
                    ),
                    const SizedBox(
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
        ));
  }
}
