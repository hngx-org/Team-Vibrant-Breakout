import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:team_vibrant_breakout/appTheme/colors.dart';
import 'package:team_vibrant_breakout/screens/authScreens/login.dart';
import 'package:team_vibrant_breakout/screens/authScreens/signup.dart';
import 'package:team_vibrant_breakout/screens/gametoolBar.dart';
import 'package:team_vibrant_breakout/screens/starterPage.dart';
import 'package:team_vibrant_breakout/screens/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  // initialize hive
  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  await Hive.initFlutter('hive_db');

  var box = await Hive.openBox('userBox');
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
      home: SplashScreen(),
    );
  }
}
