import 'package:contact_dairy/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactListProvider extends ChangeNotifier {
  List<ContactModel> contactlist = [];
  XFile? xFile;
  ImagePicker image = ImagePicker();

  void add(ContactModel contact) {
    contactlist.add(contact);
    notifyListeners();
  }

  void remove(int i) {
    contactlist.removeAt(i);
    notifyListeners();
  }

  void edit(int index, ContactModel contact) {
    contactlist[index] = contact;
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
