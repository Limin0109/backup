import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:biofuture/themes.dart';
import 'package:biofuture/utils/user_preferences.dart';
//import 'package:animated_theme_switcher/animated_theme_switcher.dart';

AppBar buildAppBar(BuildContext context) {
  final user = UserPreferences.getUser();
  //final isDarkMode = user.isDarkMode;
  //final icon = isDarkMode ? CupertinoIcons.sun_max : CupertinoIcons.moon_stars;

  return AppBar(
    leading: BackButton(),
    backgroundColor: Colors.lightBlue[100],
    elevation: 0,
    actions: [
      // ThemeSwitcher(
      // builder: (context) => IconButton(
      // icon: Icon(icon),
      // onPressed: () {
      //    final theme = isDarkMode ? MyTheme.lightTheme : MyTheme.darkTheme;
      //    final switcher = ThemeSwitcher.of(context)!;
      //   switcher.changeTheme(theme: theme);

      //   final newUser = user.copy(isDarkMode: !isDarkMode);
      //    UserPreferences.setUser(newUser);
      //   },
      //  ),
      // )
    ],
  );
}
