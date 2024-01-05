import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/contactlist_provider.dart';
import '../../model/contact_model.dart';
import '../android/add_contacts.dart';

class Calls extends StatefulWidget {
  const Calls({super.key});

  @override
  State<Calls> createState() => _CallsState();
}

class _CallsState extends State<Calls> {
  @override
  Widget build(BuildContext context) {
    return Provider.of<ContactListProvider>(context).contactlist.isNotEmpty
        ? Consumer<ContactListProvider>(
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
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadiusDirectional.only(
                                    topEnd: Radius.circular(20),
                                    topStart: Radius.circular(20),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.02,
                                      ),
                                      // CupertinoListTile(
                                      //   leading: CircleAvatar(
                                      //       radius: 30,
                                      //       child: Icon(Icons.person,
                                      //           color: cl.filepath == null
                                      //               ? Colors.white
                                      //               : Colors.transparent),
                                      //       backgroundImage: cl.filepath != null
                                      //           ? FileImage(
                                      //               File(cl.filepath!),
                                      //             )
                                      //           : null),
                                      //   trailing: PopupMenuButton(
                                      //     itemBuilder: (context) {
                                      //       return [
                                      //         PopupMenuItem(
                                      //           child: Row(
                                      //             children: [
                                      //               CupertinoButton(
                                      //                 onPressed: () {
                                      //                   Navigator.push(
                                      //                       context,
                                      //                       MaterialPageRoute(
                                      //                         builder: (context) =>
                                      //                             AddContact(
                                      //                                 index:
                                      //                                     index),
                                      //                       ));
                                      //                 },
                                      //                 child: Icon(
                                      //                   Icons.edit,
                                      //                   color: Colors.black,
                                      //                 ),
                                      //               ),
                                      //               Text("Edit"),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //         PopupMenuItem(
                                      //           child: Row(
                                      //             children: [
                                      //               CupertinoButton(
                                      //                 onPressed: () {
                                      //                   Provider.of<ContactListProvider>(
                                      //                           context,
                                      //                           listen: false)
                                      //                       .remove(index);
                                      //                   Navigator.pop(context);
                                      //                 },
                                      //                 child: Icon(
                                      //                   Icons.delete,
                                      //                   color: Colors.black,
                                      //                 ),
                                      //               ),
                                      //               Text("Delete"),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //       ];
                                      //     },
                                      //   ),
                                      //   title: Text(""),
                                      // ),
                                      // CupertinoListTile(
                                      //   title: Text(
                                      //     cl.name!,
                                      //   ),
                                      //   subtitle: Text(cl.number!),
                                      //   trailing: Row(
                                      //     mainAxisSize: MainAxisSize.min,
                                      //     children: [
                                      //       CircleAvatar(
                                      //         backgroundColor: Colors.green,
                                      //         child: IconButton(
                                      //           onPressed: () {
                                      //             var uri = Uri.parse(
                                      //                 "tel:+91${cl.number ?? ""}");
                                      //             launchUrl(uri);
                                      //           },
                                      //           icon: Icon(Icons.call,
                                      //               color: Colors.white),
                                      //         ),
                                      //       ),
                                      //       SizedBox(
                                      //         width: MediaQuery.of(context)
                                      //                 .size
                                      //                 .width *
                                      //             0.02,
                                      //       ),
                                      //       CircleAvatar(
                                      //         backgroundColor:
                                      //             Colors.blueAccent,
                                      //         child: IconButton(
                                      //           onPressed: () {},
                                      //           icon: Icon(
                                      //             Icons.message_rounded,
                                      //             color: Colors.white,
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      // CupertinoListTile(
                                      //   leading: Text(
                                      //     "Video Call",
                                      //     style: TextStyle(
                                      //         fontWeight: FontWeight.w700,
                                      //         fontSize: 20),
                                      //   ),
                                      //   trailing: CircleAvatar(
                                      //     backgroundColor: Colors.blueAccent,
                                      //     child: IconButton(
                                      //       onPressed: () {},
                                      //       icon: Icon(
                                      //         Icons.videocam_sharp,
                                      //         color: Colors.white,
                                      //       ),
                                      //     ),
                                      //   ),
                                      //   title: Text(""),
                                      // ),
                                      // CupertinoListTile(
                                      //   leading: Text(
                                      //     "WhatsApp",
                                      //     style: TextStyle(
                                      //         fontWeight: FontWeight.w700,
                                      //         fontSize: 20),
                                      //   ),
                                      //   trailing: Image.asset(
                                      //     "assets/whatsapp.png",
                                      //     color: Colors.green,
                                      //   ),
                                      //   title: Text(""),
                                      // ),
                                      // Align(
                                      //   alignment:
                                      //       AlignmentDirectional(-0.9, 0),
                                      //   child: Text(
                                      //     "Call history",
                                      //     style:
                                      //         TextStyle(color: Colors.black54),
                                      //   ),
                                      // ),
                                      // Align(
                                      //   alignment:
                                      //       AlignmentDirectional(-0.9, 0),
                                      //   child: CupertinoButton(
                                      //     onPressed: () {},
                                      //     child: Text(
                                      //       "Show more",
                                      //       style: TextStyle(
                                      //           color: Colors.blueAccent),
                                      //     ),
                                      //   ),
                                      // ),
                                      // Divider(
                                      //   color: Colors.black54,
                                      //   indent: 20,
                                      //   endIndent: 20,
                                      // ),
                                      // Align(
                                      //   alignment:
                                      //       AlignmentDirectional(-0.9, 0),
                                      //   child: Text(
                                      //     "More",
                                      //     style:
                                      //         TextStyle(color: Colors.black54),
                                      //   ),
                                      // ),
                                      // CupertinoListTile(
                                      //   leading: Text(
                                      //     "Default ringtone",
                                      //     style: TextStyle(
                                      //         fontWeight: FontWeight.w700,
                                      //         fontSize: 20),
                                      //   ),
                                      //   trailing: IconButton(
                                      //     onPressed: () {},
                                      //     icon: Icon(
                                      //       Icons.arrow_forward_ios,
                                      //     ),
                                      //   ),
                                      //   title: Text(""),
                                      // ),
                                      // CupertinoListTile(
                                      //   leading: Text(
                                      //     "QR code",
                                      //     style: TextStyle(
                                      //         fontWeight: FontWeight.w700,
                                      //         fontSize: 20),
                                      //   ),
                                      //   trailing: IconButton(
                                      //     onPressed: () {},
                                      //     icon: Icon(
                                      //       Icons.arrow_forward_ios,
                                      //     ),
                                      //   ),
                                      //   title: Text(""),
                                      // ),
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
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Not Any Calls Yet...!",
                  style: TextStyle(
                      color: Color(0xff171DF7),
                      fontSize: MediaQuery.of(context).devicePixelRatio * 7),
                ),
              ),
            ],
          );
  }
}
