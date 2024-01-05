import 'package:contact_dairy/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactListProvider extends ChangeNotifier {
  List<ContactModel> contactlist = [];

  // ImagePicker image = ImagePicker();

  void add(ContactModel contact) {
    contactlist.add(contact);
    notifyListeners();
  }





  void remove(int index) {
    contactlist.removeAt(index);
    notifyListeners();
  }

  void edit(int index, ContactModel contact) {
    contactlist[index] = contact;
    notifyListeners();
  }

}
