import 'dart:io';

import 'package:contact_dairy/controller/contactlist_provider.dart';
import 'package:contact_dairy/view/android/add_contacts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/contact_provider.dart';
import '../../model/contact_model.dart';

class ShowDetails extends StatefulWidget {
  ContactModel? contact;
  final int? index;

  ShowDetails({Key? key, this.contact, this.index}) : super(key: key);

  @override
  State<ShowDetails> createState() => _ShowDetailsState();
}

class _ShowDetailsState extends State<ShowDetails> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ContactModel? arguments =
        ModalRoute.of(context)?.settings.arguments as ContactModel?;
    widget.contact = arguments;
    print("hii${widget.contact?.name ?? ""}");

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return AddContact(
                            index: Provider.of<ContactListProvider>(
                              context,
                            ).contactlist.length,
                          );
                        },
                      ));
                    },
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
                alignment: Alignment(-0.9, 0),
                child: CircleAvatar(
                  radius: 70,
                  child: Provider.of<ContactProvider>(context).filepath == null
                      ? Icon(
                          Icons.person,
                          size: 70,
                          color: Colors.white,
                        )
                      : CircleAvatar(
                          radius: 70,
                          backgroundImage: FileImage(
                            File(widget.contact?.filepath ?? ""),
                          ),
                        ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Align(
              alignment: Alignment(-0.74, 0),
              child: Text(
                widget.contact?.name ?? "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            ListTile(
              leading: Column(
                children: [
                  Text(
                    widget.contact?.number ?? "",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  Text(
                    "Mobile | India",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        color: Colors.black54),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.call, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.blueAccent,
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
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              trailing: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.videocam_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // ListTile(
            //   leading: Text(
            //     "Video Call",
            //     style:
            //         TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            //   ),
            //   trailing: Align(
            //     alignment: Alignment(1, 0),
            //     child: Image.asset(
            //       "assets/whatsapp.png",
            //       color: Colors.green,
            //     ),
            //   ),
            // ),

            // ListTile(
            //   leading: Text(
            //     "Telegram",
            //     style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            //   ),
            //   trailing: Align(
            //     alignment: Alignment(1.1, 0),
            //     child: Image.asset(
            //       "assets/Telegram.png",
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
