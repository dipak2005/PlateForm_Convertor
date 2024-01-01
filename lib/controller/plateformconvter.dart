import 'package:flutter/material.dart';

class PlateFormCovter extends ChangeNotifier {
  bool isSwitch = false;
  bool isIos = true;

  void plateForm() {
    isSwitch = !isSwitch;
    isIos=!isIos;
    notifyListeners();
  }


}
