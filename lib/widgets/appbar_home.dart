//import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:biofuture/page/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:biofuture/themes.dart';
import 'package:biofuture/utils/user_preferences.dart';

AppBar appbarHome(BuildContext context) {
  final userHome = UserPreferences.getUser();
  //final isDarkModeHome = userHome.isDarkMode;
  //final iconHome =
  // isDarkModeHome ? CupertinoIcons.sun_max : CupertinoIcons.moon_stars;

  return AppBar(
    //leading: GestureDetector(
    //onTap: () {
    //Scaffold.of(context).openDrawer();
    //},
    //child: Icon(
    //Icons.menu,
    //),
    //),
    backgroundColor: Colors.lightBlue[100],
    elevation: 0,
    title: Text('BioFuture'),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => ProfilePage(),
            ),
          );
        },
        child: const Text('User Profile'),
      ),
      //ThemeSwitcher(
      // builder: (context) => IconButton(
      //  icon: Icon(iconHome),
      //  onPressed: () {
      //   final theme =
      //      isDarkModeHome ? MyTheme.lightTheme : MyTheme.darkTheme;
      //  final switcher = ThemeSwitcher.of(context)!;
      //   switcher.changeTheme(theme: theme);

      //  final newUserHome = userHome.copy(isDarkMode: !isDarkModeHome);
      //   UserPreferences.setUser(newUserHome);
      //  },
      //  ),
      // ),
    ],
  );
}
