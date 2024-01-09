import 'dart:io';

import 'package:contact_dairy/controller/bottonbarprovider.dart';
import 'package:contact_dairy/controller/contactlist_provider.dart';
import 'package:contact_dairy/controller/pageprovider.dart';
import 'package:contact_dairy/controller/plateformconvter.dart';
import 'package:contact_dairy/view/ios/calls.dart';
import 'package:contact_dairy/view/ios/ioschat.dart';
import 'package:contact_dairy/view/ios/iossettings.dart';
import 'package:contact_dairy/view/ios/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/contact_provider.dart';
import '../../model/contact_model.dart';
import '../android/indexstack/chats.dart';

class Home extends StatefulWidget {
  final int? index;

  const Home({super.key, this.index});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      navigationBar: CupertinoNavigationBar(
        middle: const Text(
          "Contacts",
          style: TextStyle(
              color: Color(0xff060408),
              fontSize: 25,
              fontWeight: FontWeight.w700),
        ),
        trailing: Consumer<PlateFormCovter>(
          builder: (context, plate, child) {
            return CupertinoSwitch(
              value: plate.isSwitch,
              onChanged: (value) {
                plate.plateForm();
              },
            );
          },
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Consumer<BottomBar>(
                builder: (context, page, child) {
                  return IndexedStack(
                    index: page.iconindex,
                    children: const [
                      Profile(),
                      IosChat(),
                      IosCalls(),
                      IosSettings(),
                    ],
                  );
                },
              ),
              Consumer<BottomBar>(
                builder: (BuildContext context, page, Widget? child) {
                  return CupertinoTabBar(
                    onTap: (value) {
                      page.changeIndex(value);
                    },
                    currentIndex: page.iconindex,
                    items: [
                      BottomNavigationBarItem(
                        label: "Profile",
                        tooltip: "Add Person",
                        activeIcon: Icon(
                          CupertinoIcons.person_add,
                          size: 30,
                        ),
                        icon: const Icon(
                          CupertinoIcons.person_add,
                          size: 30,
                          color: Colors.black54,
                        ),
                      ),
                      BottomNavigationBarItem(
                        label: "Chats",
                        tooltip: "Messages",
                        activeIcon:
                            Icon(CupertinoIcons.chat_bubble_2_fill, size: 30),
                        icon: const Icon(CupertinoIcons.chat_bubble_2_fill,
                            color: Colors.black54, size: 30),
                      ),
                      BottomNavigationBarItem(
                        label: "Calls",
                        tooltip: "Calls",
                        activeIcon:
                            Icon(CupertinoIcons.phone_circle_fill, size: 30),
                        icon: const Icon(CupertinoIcons.phone_circle_fill,
                            color: Colors.black54, size: 30),
                      ),
                      BottomNavigationBarItem(
                        label: "Settings",
                        tooltip: "Settings",
                        activeIcon: Icon(CupertinoIcons.settings, size: 30),
                        icon: Icon(
                          CupertinoIcons.settings,
                          size: 30,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  );
                },
              ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
