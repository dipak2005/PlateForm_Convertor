import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactProvider extends ChangeNotifier {
  bool isEdit = false;
  bool isEdit1 = false;
  bool isEdit2 = false;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  GlobalKey<FormState> gkey = GlobalKey<FormState>();
  int cindex = 0;
  XFile? xFile;
  ImagePicker image = ImagePicker();

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

  void steppercamera() {
    image.pickImage(source: ImageSource.camera).then(
      (value) {
        xFile = value;
        notifyListeners();
      },
    );
  }

  void steppergallery() {
    image.pickImage(source: ImageSource.gallery).then(
      (value) {
        xFile = value;
        notifyListeners();
      },
    );
  }

  void reset() {
    namecontroller.clear();
    emailcontroller.clear();
    phonecontroller.clear();

    cindex = 0;
  }
}
