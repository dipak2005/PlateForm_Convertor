import 'dart:io';

import 'package:contact_dairy/controller/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  ImagePicker picker = ImagePicker();
  XFile? xFile;

  GlobalKey<FormState> gkey = GlobalKey<FormState>();

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
          "Contact Details",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ContactProvider>(context, listen: false).addcontact();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.done,
              size: 30,
            ),
          ),
        ],
      ),
      body: Consumer<ContactProvider>(
        builder: (context, contact, child) {
          return Column(
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
                key: gkey,
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
                            } else if (value?.length == 10) {
                              return null;
                            } else {
                              return "Invalid Phone Number";
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
                          decoration: InputDecoration(
                              fillColor: Colors.black12,
                              filled: true,
                              hintText: "Email Address"),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Enter Email";
                            } else if (!isEmail(value ?? "")) {
                              return null;
                            } else {
                              return "Invalid Email";
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
          );
        },
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
