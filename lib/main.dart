import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/authentication/authController.dart';
//import 'package:team_vibrant_breakout/screens/authScreens/actualSplashScreen.dart';

import 'package:team_vibrant_breakout/screens/authScreens/signup.dart';
import 'package:team_vibrant_breakout/screens/gametoolBar.dart';
import 'package:team_vibrant_breakout/screens/starterPage.dart';
import 'package:team_vibrant_breakout/firebase_options.dart';

import 'package:team_vibrant_breakout/screens/splashScreen.dart';
import 'package:team_vibrant_breakout/screens/starterPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  // initialize hive
  //final dir = await path.getApplicationDocumentsDirectory();
  //Hive.init(dir.path);
  await Hive.initFlutter();
  await Hive.openBox('userBox');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthController()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: bgColor,
                  statusBarIconBrightness: Brightness.light)),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
