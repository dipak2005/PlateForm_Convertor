import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  int? currnettheme = 0;
  bool isDark = false;

  void iosTheme() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("isdark", isDark);
    isDark = !isDark;
    notifyListeners();
  }

  void getIos() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    var iosthme = preferences.getBool("isdark");
  }

  ThemeMode get thememode {
    if (currnettheme == 1) {
      return ThemeMode.light;

    } else if (currnettheme == 2) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  settheme(int theme) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("theme", theme);
    currnettheme = theme;
    notifyListeners();
  }

  gettheme() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    currnettheme = preferences.getInt("theme");
    notifyListeners();
  }
}
