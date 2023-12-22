import 'package:contact_dairy/main.dart';
import 'package:flutter/material.dart';

class Themeprovider extends ChangeNotifier {
  bool isDark = preferences.getBool("theme") ?? false;
  int? dropdown;

  bool isLight = preferences.getBool("theme1") ?? true;
  bool isdark = preferences.getBool("theme2") ?? true;

  void changeTheme() {
    isDark = !isDark;
    preferences.setBool("theme", isDark);
    notifyListeners();
  }

  void light() {
    isLight = true;

    preferences.setBool("theme1", isLight);
    notifyListeners();
  }

  void dark() {
    isdark = true;

    preferences.setBool("theme2", isdark);
    notifyListeners();
  }

  void getTheme() {
    bool? val = preferences.getBool("theme");
    bool? val1 = preferences.getBool("theme1");
    bool? val2 = preferences.getBool("theme2");
  }

  void refresh() {
    notifyListeners();
  }
}
