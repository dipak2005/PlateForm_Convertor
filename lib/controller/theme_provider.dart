import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  String currnettheme = "system";
  bool isDark = false;

  void iosTheme() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool("theme", isDark);
    isDark = !isDark;
    notifyListeners();
  }

  void getIos() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
          var iosthme = preferences.getBool("theme");
  }

  ThemeMode get thememode {
    if (currnettheme == 'light') {
      return ThemeMode.light;
    } else if (currnettheme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  settheme(String theme) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("theme", theme);
    currnettheme = theme;
    notifyListeners();
  }

  gettheme() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    currnettheme = preferences.getString("theme")!;
    notifyListeners();
  }
}
