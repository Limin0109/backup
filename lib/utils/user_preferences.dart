import 'package:biofuture/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyUser = 'user';
  static const myUser = User(
    imagePath:
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/cL6JccAYqiZQEAIEFObEUC9LTt7.jpg',
    name: 'Crystal Liu',
    email: 'operatingsystemtest@gmail.com',
    about: 'Certified Bioinformatician',
    //isDarkMode: false,
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());
    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
