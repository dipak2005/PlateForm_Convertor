import 'dart:io';

import 'package:contact_dairy/controller/contactlist_provider.dart';
import 'package:contact_dairy/controller/pageprovider.dart';
import 'package:contact_dairy/controller/theme_provider.dart';
import 'package:contact_dairy/model/contact_model.dart';
import 'package:contact_dairy/view/add_contacts.dart';
import 'package:contact_dairy/view/details.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final LocalAuthentication auth = LocalAuthentication();
  bool isSwitch = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    error();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Contacts",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "Settings");
            },
            icon: const Icon(
              Icons.settings,
            ),
          ),
          Switch(
            inactiveTrackColor: Colors.black38,
            activeColor: Colors.white,
            activeTrackColor: Colors.green,
            value: isSwitch,
            onChanged: (value) {
              isSwitch = value;
              setState(() {});
            },
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.08,
            width: MediaQuery.sizeOf(context).width,
            child: Expanded(
              child: Consumer<PageProvider>(
                builder: (BuildContext context, stack, Widget? child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          stack.page = 0;
                          stack.prePage();
                        },
                        icon: Icon(Icons.person_add_alt_1_outlined),
                      ),
                      TextButton(
                        onPressed: () {
                          stack.page = 1;
                          stack.prePage();
                        },
                        child: Text("CHATS"),
                      ),
                      TextButton(
                        onPressed: () {
                          stack.page = 2;
                          stack.prePage();
                        },
                        child: Text("CALLS"),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Divider(
            color: Colors.black38,
          ),
          IndexedStack(
            index: Provider.of<PageProvider>(
              context,
            ).page,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.78,
                child: Column(
                  children: [
                    Expanded(
                      child: Consumer<ContactListProvider>(
                        builder: (context, contact, child) {
                          return ListView.builder(
                            itemCount: contact.contactlist.length,
                            itemBuilder: (context, index) {
                              ContactModel cl = contact.contactlist[index];
                              return ListTile(
                                onTap: () {
                                  var uri =
                                      Uri.parse("tel:+91${cl.number ?? ""}");
                                  launchUrl(uri);
                                },
                                onLongPress: () {
                                  Provider.of<ContactListProvider>(context,
                                          listen: false)
                                      .remove(index);
                                },
                                leading: Stack(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: contact.xFile != null
                                          ? FileImage(
                                              File(contact.xFile!.path),
                                            )
                                          : null,
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      right: 10,
                                      child: Icon(
                                        Icons.person,
                                        color: contact.xFile == null
                                            ? Colors.white
                                            : Colors.transparent,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                title: Text(
                                  cl.name ?? "",
                                ),
                                subtitle: Text(
                                  cl.number ?? "",
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ShowDetails(contact: cl),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.arrow_circle_right_sharp,
                                      size: 30),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final bool canAuthenticateWithBiometrics =
                            await auth.canCheckBiometrics;
                        final bool canAuthenticate =
                            canAuthenticateWithBiometrics ||
                                await auth.isDeviceSupported();
                        print("$canAuthenticate");
                        print("${canAuthenticateWithBiometrics}");

                        final List<BiometricType> availableBiometrics =
                            await auth.getAvailableBiometrics();
                        print(availableBiometrics);

                        try {
                          print('auth.authenticate');
                          final bool didAuthenticate = await auth.authenticate(
                            localizedReason:
                                'Please authenticate to show account balance',
                          );
                          print(didAuthenticate);
                        } on PlatformException catch (e) {
                          print("error ==> $e");
                        }
                      },
                      child: Text("Local"),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.76,
                      child: Text(
                        "NO ANY CHATS YET...!",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: MediaQuery.sizeOf(context).height * 0.76,
                      child: Text(
                        "NO ANY CALLS YET...!",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Consumer<Themeprovider1>(
        builder: (context, theme, child) => FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () async {
            await Navigator.pushNamed(
              context,
              "AddContact",
            );
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  void error() async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      print("hello");
      final bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance',
          options: const AuthenticationOptions(useErrorDialogs: false));
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        // Add handling of no hardware here.
      } else if (e.code == auth_error.lockedOut ||
          e.code == auth_error.permanentlyLockedOut) {
      } else {}
    }
  }
}
