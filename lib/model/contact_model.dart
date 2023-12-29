import 'package:image_picker/image_picker.dart';

class ContactModel{
  String? name;
  String? email;
  String? number;
  XFile? xFile;
  ContactModel({this.name, this.email, this.number, this.xFile});
}