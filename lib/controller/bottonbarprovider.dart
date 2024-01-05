import 'package:flutter/material.dart';

class BottomBar extends ChangeNotifier {
  int iconindex = 0;

  void changeIndex(int index) {
    iconindex = index;
    notifyListeners();
  }
}
