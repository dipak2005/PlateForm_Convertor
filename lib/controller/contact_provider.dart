import 'package:contact_dairy/model/contct_model.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactProvider extends ChangeNotifier {

  bool isEdit = false;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  GlobalKey<FormState> gkey = GlobalKey<FormState>();
  int cindex = 0;
  XFile? xFile;
  ImagePicker image = ImagePicker();
  List<ContactModel> contactlist = [];

  void addcontact() {
    contactlist.add(
      ContactModel(namecontroller.text, emailcontroller.text,
          phonecontroller.text, xFile),
    );
    notifyListeners();
  }
  void refresh(){
    notifyListeners();
  }
  void steppercontinue() {
    isEdit = true;
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
}
