import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  int page = 0;

  void prePage() {
    page;
    notifyListeners();
  }
}
