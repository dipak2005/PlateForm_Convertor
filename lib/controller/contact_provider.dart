import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  GlobalKey<FormState> gkey = GlobalKey<FormState>();
  int cindex = 0;

  void pickImage(bool isCamera) async {
    XFile? file = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    filepath = file?.path;
    notifyListeners();
  }

  setContact(String filepath) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("image", filepath ?? "");
    contact = filepath ?? "";
    notifyListeners();
  }

  getContact() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    contact = preferences.getString("image");
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

  // void steppercamera() {
  //   image.pickImage(source: ImageSource.camera).then(
  //     (value) {
  //       xFile = value;
  //       notifyListeners();
  //     },
  //   );
  // }
  //
  // void steppergallery() {
  //   image.pickImage(source: ImageSource.gallery).then(
  //     (value) {
  //       xFile = value;
  //       notifyListeners();
  //     },
  //   );
  // }

  void reset() {
    namecontroller.clear();
    emailcontroller.clear();
    phonecontroller.clear();
    filepath?.trim();
    cindex = 0;
  }
}
