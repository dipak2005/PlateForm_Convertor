import 'dart:io';

import 'package:contact_dairy/controller/contact_provider.dart';
import 'package:contact_dairy/controller/contactlist_provider.dart';
import 'package:contact_dairy/controller/pageprovider.dart';
import 'package:contact_dairy/controller/plateformconvter.dart';
import 'package:contact_dairy/controller/theme_provider.dart';
import 'package:contact_dairy/model/contact_model.dart';
import 'package:contact_dairy/view/android/details.dart';
import 'package:contact_dairy/view/android/indexstack/calls.dart';
import 'package:contact_dairy/view/android/indexstack/chats.dart';
import 'package:contact_dairy/view/android/indexstack/contactlist.dart';
import 'package:contact_dairy/view/android/indexstack/settings.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // error();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(elevation: 1,
          title: Text(
            "Contacts",
          ),
          actions: [
            Consumer<PlateFormCovter>(
                builder: (BuildContext context, plate, Widget? child) {
              return Switch(
                inactiveTrackColor: Colors.black38,
                activeColor: Colors.white,
                activeTrackColor: Colors.green,
                value: plate.isSwitch,
                onChanged: (value) {
                  plate.plateForm();
                },
              );
            })
          ],
          bottom: TabBar(
            tabs: [
              Icon(
                Icons.person_add_alt_1_outlined,
                size: MediaQuery.of(context).devicePixelRatio * 8,
              ),
              Text("CHATS",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).devicePixelRatio * 4)),
              Text("CALLS",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).devicePixelRatio * 4)),
              Text("SETTINGS",
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).devicePixelRatio * 4)),
            ],
          ),
        ),
        body: TabBarView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            const Contactlist(),
            const Chats(),
            const Calls(),
            Settings(),
          ],
        ),
      ),
    );
  }

// void error() async {
//   final LocalAuthentication auth = LocalAuthentication();
//   try {
//     print("hello");
//     final bool didAuthenticate = await auth.authenticate(
//         localizedReason: 'Please authenticate to show account balance',
//         options: const AuthenticationOptions(useErrorDialogs: false));
//   } on PlatformException catch (e) {
//     if (e.code == auth_error.notEnrolled) {
//       // Add handling of no hardware here.
//     } else if (e.code == auth_error.lockedOut ||
//         e.code == auth_error.permanentlyLockedOut) {
//     } else {}
//   }
// }
}
