import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactModel{
  String? name;
  String? email;
  String? number;
  String? filepath;
  String?  chats;
  DateTime? date;
  TimeOfDay? time;
  ContactModel({this.name, this.email, this.number, this.filepath,this.chats,this.time,this.date});
}