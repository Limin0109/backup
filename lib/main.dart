//import 'dart:html';

import 'package:biofuture/page/login_screen.dart';
import 'package:biofuture/page/onboarding_page.dart';
//import 'package:biofuture/page/patreonMenu.dart';
import 'package:biofuture/utils/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:animated_theme_switcher/animated_theme_switcher.dart';
//import 'package:biofuture/themes.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await UserPreferences.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'User Profile';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return MaterialApp(
      title: 'Email And PassWord Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: OnBoardingPage(),
    );
  }
}
