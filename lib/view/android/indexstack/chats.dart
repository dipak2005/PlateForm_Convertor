import 'dart:io';

import 'package:contact_dairy/view/android/indexstack/contactlist.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controller/contact_provider.dart';
import '../../../controller/contactlist_provider.dart';
import '../add_contacts.dart';

class Chats extends StatefulWidget {
  final int? index;

  const Chats({super.key, this.index});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<ContactProvider>(context).chatcontroller != null
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
                                elevation: 6,
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
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.02,
                                        ),
                                        Center(
                                          child: CircleAvatar(
                                              radius: 60,
                                              child: Icon(Icons.person,
                                                  color: cl.filepath == null
                                                      ? Colors.white
                                                      : Colors.transparent,
                                                  size: 49),
                                              backgroundImage:
                                                  cl.filepath != null
                                                      ? FileImage(
                                                          File(cl.filepath!),
                                                        )
                                                      : null),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.02,
                                        ),
                                        Text(
                                          cl.name!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.01,
                                        ),
                                        Text(
                                          cl.chats!,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.02,
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return Contactlist(
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
                                              SizedBox(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.1,
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      Provider.of<ContactListProvider>(
                                                              context,
                                                              listen: false)
                                                          .remove(index);
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  Text("Delete",
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
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
                                child: Icon(Icons.person,
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
                              cl.chats ?? "",
                            ),
                            trailing: Text(
                              cl.date != null
                                  ? "${cl.date?.day}/${cl.date?.month}/${cl.date?.year},${cl.time?.hour}:${cl.time?.minute}"
                                  : "",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
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
                      "NO ANY CHATS YET...!",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
