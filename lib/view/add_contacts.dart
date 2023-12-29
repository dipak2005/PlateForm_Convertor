import 'dart:io';

import 'package:contact_dairy/controller/contact_provider.dart';
import 'package:contact_dairy/controller/contactlist_provider.dart';
import 'package:contact_dairy/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddContact extends StatefulWidget {
  final int? index;

  const AddContact({Key? key, this.index}) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  String title = " Add Contact";

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

      title = "Edit Contact";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Consumer<ContactProvider>(
        builder: (context, contact, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: IconButton(
                        onPressed: () {
                          contact.steppercamera();
                        },
                        icon: Icon(
                          Icons.person,
                          color: contact.xFile == null
                              ? Colors.white
                              : Colors.transparent,
                          size: 30,
                        ),
                      ),
                      radius: 60,
                      backgroundImage: contact.xFile != null
                          ? FileImage(File(contact.xFile?.path ?? ""))
                          : null,
                    ),
                  ],
                ),
                Form(
                  key: contact.gkey,
                  child: Stepper(
                    currentStep: contact.cindex,
                    onStepContinue: () {
                      contact.steppercontinue();
                    },
                    onStepCancel: () {
                      contact.steppercancel();
                    },
                    onStepTapped: (value) {
                      contact.stepperTapped();
                    },
                    controlsBuilder: (context, details) {
                      return Row(
                        children: [
                          if (details.currentStep != 2)
                            ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: details.onStepContinue,
                              child: Text("CONTINUE"),
                            ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.01,
                          ),
                          if (details.currentStep != 0)
                            ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: details.onStepCancel,
                              child: Text("Cancel"),
                            )
                        ],
                      );
                    },
                    steps: [
                      Step(
                          title: Text("Step 1"),
                          content: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.person, color: Colors.white),
                                hintText: "Name",
                                filled: true,
                                fillColor: Colors.black12),
                            controller: contact.namecontroller,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Enter Name";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.name,
                          ),
                          isActive: contact.cindex >= 0,
                          state: (contact.namecontroller.text.isEmpty &&
                                  contact.isEdit &&
                                  contact.cindex != 0)
                              ? StepState.error
                              : StepState.editing),
                      Step(
                          title: Text("Step 2"),
                          content: TextFormField(
                            controller: contact.phonecontroller,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Enter Phone Number";
                              } else if (value?.length != 10) {
                                return "Invalid Phone Number";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.black12,
                                filled: true,
                                hintText: "Phone Number"),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.phone,
                          ),
                          isActive: contact.cindex >= 1,
                          state: (contact.phonecontroller.text.isEmpty &&
                                  contact.isEdit &&
                                  contact.cindex != 1)
                              ? StepState.error
                              : StepState.editing),
                      Step(
                          title: Text("Step 3"),
                          content: TextFormField(
                            controller: contact.emailcontroller,
                            decoration: InputDecoration(
                                fillColor: Colors.black12,
                                filled: true,
                                hintText: "Email Address"),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return "Enter Email";
                              } else if (!isEmail(value ?? "")) {
                                return "Invalid Email";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          isActive: contact.cindex >= 2,
                          state: (contact.namecontroller.text.isEmpty &&
                                  contact.isEdit &&
                                  contact.cindex != 2)
                              ? StepState.error
                              : StepState.editing)
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var cp = Provider.of<ContactProvider>(context, listen: false);

          if (cp.gkey.currentState?.validate() ?? false) {
            ContactModel cm = ContactModel(
                number: cp.phonecontroller.text,
                email: cp.emailcontroller.text,
                xFile: cp.xFile,
                name: cp.namecontroller.text);

            if (widget.index != null) {
              Provider.of<ContactListProvider>(context, listen: false)
                  .edit(widget.index!, cm);
            } else {
              Provider.of<ContactListProvider>(context, listen: false).add(cm);
              // print(" my name is dipak${widget.index}");
            }

            Provider.of<ContactProvider>(context, listen: false).reset();
            Navigator.pop(context);
          }

          print("====>${widget.index}");
        },
        child: Icon(widget.index != null ? Icons.edit : Icons.add),
      ),
    );
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }
}
