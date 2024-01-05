import 'package:flutter/material.dart';

class PlateFormCovter extends ChangeNotifier {
  bool isSwitch = false;
  bool ispro=false;
  bool isIos = true;

  void plateForm() {
    isSwitch = !isSwitch;
    isIos=!isIos;
    notifyListeners();
  }
  void Pro() {
    ispro = !ispro;

    notifyListeners();
  }

}
