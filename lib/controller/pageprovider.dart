import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  int page = 0;
  CupertinoTabController tabController = CupertinoTabController();

  void prePage(int index) {
    page;
    notifyListeners();
  }
}
