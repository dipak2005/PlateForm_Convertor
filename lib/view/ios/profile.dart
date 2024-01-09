import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controller/contact_provider.dart';
import '../../controller/contactlist_provider.dart';
import '../../controller/pageprovider.dart';
import '../../controller/plateformconvter.dart';
import '../../model/contact_model.dart';
import '../android/indexstack/calls.dart';
import '../android/indexstack/chats.dart';
import 'ioschat.dart';
import 'iossettings.dart';

class Profile extends StatefulWidget {
  final int? index;

  const Profile({super.key, this.index});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String title = " Save";
  final format = DateFormat("dd -MM -yyyy");

  @override
  void initState() {
    super.initState();
    var cm = Provider.of<ContactProvider>(context, listen: false);

    if (widget.index != null) {
      var clp = Provider.of<ContactListProvider>(context, listen: false);
      var cmd = clp.contactlist[widget.index!];
      cm.phonecontroller.text = cmd.number ?? "";
      cm.namecontroller.text = cmd.name ?? "";
      cm.emailcontroller.text = cmd.email ?? "";

      title = " Add ";
    }
  }

  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(30),
            child: Consumer<ContactProvider>(
                builder: (context, contactprovider, child) {
              return SingleChildScrollView(
                child: Container(
                  height: MediaQuery.sizeOf(context).height * 0.77,
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20),
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Colors.grey, spreadRadius: 1, blurRadius: 15),
                    // ],
                  ),
                  child: Consumer<ContactProvider>(
                    builder: (BuildContext context, contact, Widget? child) {
                      return Form(
                        key: contact.iosKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  minRadius: 50,
                                  backgroundImage: contact.filepath != null
                                      ? FileImage(
                                          File(contact.filepath ?? ""),
                                        )
                                      : null,
                                  child: contact.filepath == null
                                      ? CupertinoButton(
                                          onPressed: () {
                                            contact.pickImage(true);
                                          },
                                          child: const Icon(
                                            Icons.add_a_photo_outlined,
                                            color: Colors.white,
                                            size: 30,
                                          ),
                                        )
                                      : null,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 20, right: 20),
                                child: CupertinoTextFormFieldRow(
                                  placeholder: "Full Name",
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return "Enter Name";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: contact.namecontroller,
                                  keyboardType: TextInputType.name,
                                  prefix: Icon(CupertinoIcons.person_alt_circle,
                                      size: 25),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black38),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, left: 20, right: 20),
                                child: CupertinoTextFormFieldRow(
                                  placeholder: "Phone Number",
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return "Enter Phone Number";
                                    } else if (value?.length != 10) {
                                      return "Invalid Phone Number";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: contact.phonecontroller,
                                  keyboardType: TextInputType.phone,
                                  prefix: Icon(CupertinoIcons.phone),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black38),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: CupertinoTextFormFieldRow(
                                  placeholder: "Chats Conversation",
                                  keyboardType: TextInputType.name,
                                  prefix: Icon(CupertinoIcons.chat_bubble_text),
                                  validator: (value) {
                                    if (value?.isEmpty ?? true) {
                                      return " Plz Enter Bio";
                                    } else {
                                      return null;
                                    }
                                  },
                                  controller: contact.chatcontroller,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.black38),
                                  ),
                                ),
                              ),
                              Consumer<ContactProvider>(
                                builder: (BuildContext context, data,
                                    Widget? child) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: 180),
                                    child: TextButton(
                                      onPressed: () async {
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.3,
                                              width: MediaQuery.sizeOf(context)
                                                  .width,
                                              decoration: BoxDecoration(
                                                  color: Colors.white),
                                              child: CupertinoDatePicker(
                                                use24hFormat: false,
                                                maximumDate: DateTime(2050),
                                                maximumYear: 1990,
                                                initialDateTime: DateTime.now(),
                                                dateOrder:
                                                    DatePickerDateOrder.dmy,
                                                onDateTimeChanged: (value) {
                                                  data.changedata(value);
                                                  data.Date = value;
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            CupertinoIcons.calendar,
                                          ),
                                          Text(
                                            data.Date == null
                                                ? "Pick Date"
                                                : "${data.Date?.day}/${data.Date?.month}/${data.Date?.year}",
                                            style: TextStyle(
                                                color: Colors.blueAccent),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              Consumer<ContactProvider>(
                                builder: (BuildContext context, time,
                                    Widget? child) {
                                  return Padding(
                                    padding: EdgeInsets.only(right: 180.0),
                                    child: TextButton(
                                      onPressed: () async {
                                        showCupertinoModalPopup(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.3,
                                              width: MediaQuery.sizeOf(context)
                                                  .width,
                                              decoration: BoxDecoration(
                                                  color: Colors.white),
                                              child: CupertinoDatePicker(
                                                use24hFormat: false,
                                                showDayOfWeek: true,
                                                mode: CupertinoDatePickerMode
                                                    .time,
                                                onDateTimeChanged: (value) {
                                                  time.changedata(value);
                                                  time.datetime = value;
                                                },
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Row(
                                        // mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(CupertinoIcons.clock),
                                          Text(
                                            time.datetime == null
                                                ? "Pick Time"
                                                : "${time.Date?.hour}:${time.Date?.minute}",
                                            style: TextStyle(
                                                color: Colors.blueAccent),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    fixedSize: Size(
                                        MediaQuery.sizeOf(context).width * 0.3,
                                        MediaQuery.sizeOf(context).height *
                                            0.05)),
                                onPressed: () {
                                  var cp = Provider.of<ContactProvider>(context,
                                      listen: false);
                                  if (cp.iosKey.currentState?.validate() ??
                                      false) {
                                    ContactModel cm = ContactModel(
                                        number: cp.phonecontroller.text,
                                        email: cp.emailcontroller.text,
                                        filepath: cp.filepath,
                                        name: cp.namecontroller.text,
                                        chats: cp.chatcontroller.text,
                                        date: cp.Date,
                                        time: cp.Time);

                                    if (widget.index != null) {
                                      Provider.of<ContactListProvider>(context,
                                              listen: false)
                                          .edit(widget.index!, cm);

                                      cp.reset();
                                    } else {
                                      Provider.of<ContactListProvider>(context,
                                              listen: false)
                                          .add(cm);
                                    }

                                    cp.reset();
                                  }
                                },
                                child: Text(
                                  title,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
