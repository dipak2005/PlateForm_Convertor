

import 'package:contact_dairy/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactProvider extends ChangeNotifier {




  bool isEdit = false;
  bool isEdit1 = false;
  bool isEdit2 = false;
  String? filepath;
  String? contact;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController chatcontroller = TextEditingController();
  GlobalKey<FormState> gkey = GlobalKey<FormState>();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  GlobalKey<FormState> iosEditKey = GlobalKey<FormState>();
  GlobalKey<FormState> iosKey = GlobalKey<FormState>();
  int cindex = 0;
  DateTime? Date;
  TimeOfDay? Time;
  DateTime? datetime = DateTime.now();

  void pickImage(bool isCamera) async {
    XFile? file = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
   filepath = file?.path;
    notifyListeners();
  }



  void refresh() {
    notifyListeners();
  }

  void steppercontinue() {
    isEdit1 = true;
    if (cindex < 2) {
      cindex++;
    }
    notifyListeners();
  }

  void steppercancel() {
    if (cindex > 0) {
      cindex--;
    }
    notifyListeners();
  }

  void stepperTapped() {
    notifyListeners();
  }

  void changedata(DateTime dateTime) {
    this.datetime = datetime;
    notifyListeners();
  }

  void reset() {
    namecontroller.clear();
    emailcontroller.clear();
    phonecontroller.clear();
    chatcontroller.clear();
    filepath = null;
    cindex = 0;
    Time = null;
    Date = null;
    datetime = null;
    notifyListeners();
  }
}
