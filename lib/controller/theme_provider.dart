import 'package:contact_dairy/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ThemeMode theme(BuildContext context) {
//   final themeProvider = Provider.of<Themeprovider>(context).selectedTheme;
//   // int selectedTheme = themeProvider.selectedTheme;
//
//   switch (themeProvider) {
//     case 0:
//       return ThemeMode.light;
//     case 1:
//       return ThemeMode.dark;
//     default:
//       return ThemeMode.system;
//   }
// }

// void setTheme(int theme) {
//   selectedTheme = theme;
//   notifyListeners();
// }
//
// void getTheme() {
//   bool? val = preferences.getBool("theme");
// }
//
// void refresh() {
//   notifyListeners();
// }

// enum AppTheme {
//   light("Light Mode"),
//   dark("Dark Mode"),
//   system("System");
//
//   final String name;
//
//   const AppTheme(this.name);
// }

// class Themeprovider1 extends ChangeNotifier {
//   AppTheme themeData = AppTheme.system;
//
//   void setTheme(AppTheme theme) {
//     themeData = theme;
//     preferences.setStringList('items', <String>['Light', 'Dark', 'System']);
//     notifyListeners();
//   }
//
//   bool isDark = preferences.getBool("theme") ?? false;
//   bool theme = preferences.getBool("theme") ?? false;
//
//   void changeTheme() {
//     isDark = !isDark;
//     preferences.setBool("theme", isDark);
//     notifyListeners();
//   }
//
//   void getTheme() {
//     bool? val = preferences.getBool("theme");
//     List<String>? items = preferences.getStringList('items');
//   }
//
//   void refresh() {
//     notifyListeners();
//   }
// }

class Themeprovider1 extends ChangeNotifier {
  int? selectedthem;
  late ThemeMode themeMode;
  late String SelectedThemeKey;
  final String themeKey = "selectedTheme";

  Themeprovider1() {
    SelectedThemeKey = themeKey;
    loadTheme();
  }

  void loadTheme() async {
    final preferences = await SharedPreferences.getInstance();
    print(themeKey);
    SelectedThemeKey = preferences.getString(themeKey) ?? "system";

    _setTheme();
  }

  void _setTheme() {
    switch (SelectedThemeKey) {
      case "light":
        themeMode = ThemeMode.light;
        break;
      case "dark":
        themeMode = ThemeMode.dark;
      case "system":
        themeMode = ThemeMode.system;
      default:
        themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  void setTheme(String themeKey) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(themeKey, themeKey);
    SelectedThemeKey = themeKey;
    _setTheme();
  }

  // void getTheme() {
  //   bool? val = preferences.getBool(themeKey);
  // }
}
