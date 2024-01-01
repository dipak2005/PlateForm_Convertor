
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  String currnettheme = "system";

  ThemeMode get  thememode {
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
