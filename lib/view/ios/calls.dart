import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/contactlist_provider.dart';
import '../../controller/plateformconvter.dart';
import '../../model/contact_model.dart';
import '../android/add_contacts.dart';

class IosCalls extends StatefulWidget {
  const IosCalls({super.key});

  @override
  State<IosCalls> createState() => _IosCallsState();
}

class _IosCallsState extends State<IosCalls> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      child: Provider.of<ContactListProvider>(context).contactlist.isNotEmpty
          ? SafeArea(
              child: Consumer<ContactListProvider>(
                builder: (context, contact, child) {
                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.82,
                    child: ListView.builder(
                      itemCount: contact.contactlist.length,
                      itemBuilder: (context, index) {
                        ContactModel cl = contact.contactlist[index];
                        return CupertinoListTile(
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.7,
                                    width: MediaQuery.sizeOf(context).width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadiusDirectional.only(
                                        topEnd: Radius.circular(20),
                                        topStart: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.02,
                                        ),
                                        CupertinoListTile(
                                          title: CircleAvatar(
                                              radius: 30,
                                              child: Icon(CupertinoIcons.person_alt,
                                                  color: cl.filepath == null
                                                      ? Colors.white
                                                      : Colors.transparent),
                                              backgroundImage:
                                                  cl.filepath != null
                                                      ? FileImage(
                                                          File(cl.filepath!),
                                                        )
                                                      : null),

                                          // title: Text(""),
                                        ),
                                        CupertinoListTile(
                                          title: Text(
                                            cl.name!,
                                          ),
                                          subtitle: Text(cl.number!),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CupertinoButton(
                                                onPressed: () {
                                                  var uri = Uri.parse(
                                                      "tel:+91${cl.number ?? ""}");
                                                  launchUrl(uri);
                                                },
                                                child: Icon(
                                                  CupertinoIcons
                                                      .phone_circle_fill,
                                                  color: Colors.green,
                                                  size: 40,
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02,
                                              ),
                                              CupertinoButton(
                                                onPressed: () {},
                                                child: Icon(
                                                  CupertinoIcons
                                                      .chat_bubble_text_fill,
                                                  color: Colors.orange,
                                                  size: 40,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        CupertinoListTile(
                                          title: Text(
                                            "Video Call",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20),
                                          ),
                                          trailing: CupertinoButton(
                                            onPressed: () {},
                                            child: Icon(
                                              CupertinoIcons
                                                  .videocam_circle_fill,
                                              color: Colors.blueAccent,
                                              size: 40,
                                            ),
                                          ),
                                        ),
                                        CupertinoListTile(
                                          trailing: CupertinoButton(
                                            onPressed: () {},
                                            child: Image.asset(
                                              "assets/whatsapp.png",
                                              color: Colors.green,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.1,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.1,
                                            ),
                                          ),
                                          title: Text(
                                            "WhatsApp",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20),
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
                                          child: CupertinoButton(
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
                                        CupertinoListTile(
                                          title: Text(
                                            "Default ringtone",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20),
                                          ),
                                          trailing: CupertinoButton(
                                            onPressed: () {},
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                            ),
                                          ),
                                        ),
                                        CupertinoListTile(
                                          title: Text(
                                            "QR code",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20),
                                          ),
                                          trailing: CupertinoButton(
                                            onPressed: () {},
                                            child: Icon(
                                              Icons.arrow_forward_ios,
                                            ),
                                          ),
                                        ),
                                        // Container(
                                        //   child: Expanded(
                                        //     child: Row(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.spaceAround,
                                        //       mainAxisSize: MainAxisSize.min,
                                        //       children: [
                                        //         Column(
                                        //           mainAxisSize: MainAxisSize.min,
                                        //           children: [
                                        //             CupertinoButton(
                                        //               onPressed: () {},
                                        //               child: Icon(
                                        //                 CupertinoIcons.heart,
                                        //                 size: 30,
                                        //               ),
                                        //             ),
                                        //             Text("Favourite",
                                        //                 style: TextStyle(
                                        //                     color: Colors.black)),
                                        //           ],
                                        //         ),
                                        //         Column(
                                        //           mainAxisSize: MainAxisSize.min,
                                        //           children: [
                                        //             CupertinoButton(
                                        //               onPressed: () {
                                        //                 Navigator.push(
                                        //                   context,
                                        //                   MaterialPageRoute(
                                        //                     builder: (context) {
                                        //                       return AddContact(
                                        //                           index: index);
                                        //                     },
                                        //                   ),
                                        //                 );
                                        //               },
                                        //               child: Icon(
                                        //                 CupertinoIcons.pen,
                                        //                 size: 30,
                                        //               ),
                                        //             ),
                                        //             Text(
                                        //               "Edit contact",
                                        //               style: TextStyle(
                                        //                   color: Colors.black),
                                        //             )
                                        //           ],
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  );
                                });
                          },
                          leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 60,
                              child: Icon(CupertinoIcons.person_alt_circle_fill,
                                  color: cl.filepath == null
                                      ? Colors.white
                                      : Colors.transparent,
                                  size: 30),
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
                          trailing: CupertinoButton(
                            child: const Icon(CupertinoIcons.phone),
                            onPressed: () {
                              var uri = Uri.parse("tel:+91${cl.number ?? ""}");
                              launchUrl(uri);
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          : Container(
              height: MediaQuery.sizeOf(context).height * 0.8,
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.phone_fill,
                      size: MediaQuery.of(context).devicePixelRatio * 10),
                  Text(
                    "Not Any Messages Yet...!",
                    style: TextStyle(
                        color: Color(0xff171DF7),
                        fontSize: MediaQuery.of(context).devicePixelRatio * 7),
                  ),
                ],
              ),
            ),
    );
  }
}
