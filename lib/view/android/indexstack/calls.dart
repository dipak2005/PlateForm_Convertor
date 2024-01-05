import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controller/contactlist_provider.dart';
import '../add_contacts.dart';

class Calls extends StatefulWidget {
  const Calls({super.key});

  @override
  State<Calls> createState() => _CallsState();
}

class _CallsState extends State<Calls> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<ContactListProvider>(context).contactlist.isNotEmpty
          ? Column(
              children: [
                Consumer<ContactListProvider>(
                  builder: (context, contact, child) {
                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.7,
                      child: ListView.builder(
                        itemCount: contact.contactlist.length,
                        itemBuilder: (context, index) {
                          var cl = contact.contactlist[index];
                          return ListTile(
                            onTap: () {
                              showBottomSheet(
                                enableDrag: false,
                                elevation: 3,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadiusDirectional.only(
                                        topEnd: Radius.circular(20),
                                        topStart: Radius.circular(20),
                                      ),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        // mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.02,
                                          ),
                                          ListTile(
                                            leading: CircleAvatar(
                                                radius: 30,
                                                child: Icon(Icons.person,
                                                    color: cl.filepath == null
                                                        ? Colors.white
                                                        : Colors.transparent),
                                                backgroundImage:
                                                    cl.filepath != null
                                                        ? FileImage(
                                                            File(cl.filepath!),
                                                          )
                                                        : null),
                                            trailing: PopupMenuButton(
                                              itemBuilder: (context) {
                                                return [
                                                  PopupMenuItem(
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      AddContact(
                                                                          index:
                                                                              index),
                                                                ));
                                                          },
                                                          icon: Icon(
                                                            Icons.edit,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Text("Edit"),
                                                      ],
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {
                                                            Provider.of<ContactListProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .remove(index);
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Text("Delete"),
                                                      ],
                                                    ),
                                                  ),
                                                ];
                                              },
                                            ),
                                          ),
                                          ListTile(
                                            title: Text(
                                              cl.name!,
                                            ),
                                            subtitle: Text(cl.number!),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: Colors.green,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      var uri = Uri.parse(
                                                          "tel:+91${cl.number ?? ""}");
                                                      launchUrl(uri);
                                                    },
                                                    icon: Icon(Icons.call,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02,
                                                ),
                                                CircleAvatar(
                                                  backgroundColor:
                                                      Colors.blueAccent,
                                                  child: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.message_rounded,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ListTile(
                                            leading: Text(
                                              "Video Call",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20),
                                            ),
                                            trailing: CircleAvatar(
                                              backgroundColor:
                                                  Colors.blueAccent,
                                              child: IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.videocam_sharp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            leading: Text(
                                              "WhatsApp",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20),
                                            ),
                                            trailing: Image.asset(
                                              "assets/whatsapp.png",
                                              color: Colors.green,
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-0.9, 0),
                                            child: Text(
                                              "Call history",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-0.9, 0),
                                            child: TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                "Show more",
                                                style: TextStyle(
                                                    color: Colors.blueAccent),
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.black54,
                                            indent: 20,
                                            endIndent: 20,
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-0.9, 0),
                                            child: Text(
                                              "More",
                                              style: TextStyle(
                                                  color: Colors.black54),
                                            ),
                                          ),
                                          ListTile(
                                            leading: Text(
                                              "Default ringtone",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20),
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.arrow_forward_ios,
                                              ),
                                            ),
                                          ),
                                          ListTile(
                                            leading: Text(
                                              "QR code",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20),
                                            ),
                                            trailing: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.arrow_forward_ios,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.favorite_border,
                                                        size: 30,
                                                      ),
                                                    ),
                                                    Text("Favourite",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black)),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return AddContact(
                                                                  index: index);
                                                            },
                                                          ),
                                                        );
                                                      },
                                                      icon: Icon(
                                                        Icons.edit_note_sharp,
                                                        size: 30,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Edit contact",
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            onLongPress: () {
                              Provider.of<ContactListProvider>(context,
                                      listen: false)
                                  .remove(index);
                            },
                            leading: CircleAvatar(
                                child: Icon(CupertinoIcons.person,
                                    color: cl.filepath == null
                                        ? Colors.white
                                        : Colors.transparent),
                                backgroundImage: cl.filepath != null
                                    ? FileImage(
                                        File(cl.filepath!),
                                      )
                                    : null),
                            title: Text(
                              cl.name!,
                            ),
                            subtitle: Text(
                              cl.number!,
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                var uri =
                                    Uri.parse("tel:+91${cl.number ?? ""}");
                                launchUrl(uri);
                              },
                              icon: Icon(
                                Icons.add_ic_call_outlined,
                                color: Colors.green,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            )
          : Column(
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
    );
  }
}
