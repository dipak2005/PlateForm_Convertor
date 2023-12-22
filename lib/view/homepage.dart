import 'dart:io';

import 'package:contact_dairy/controller/contact_provider.dart';
import 'package:contact_dairy/controller/theme_provider.dart';
import 'package:contact_dairy/model/contct_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contacts",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "Settings");
            },
            icon: Icon(
              Icons.settings,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, "Search"),
              child: Consumer<Themeprovider>(
                builder: (context, theme, child) => Container(
                  height: MediaQuery.sizeOf(context).height * 0.07,
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  decoration: BoxDecoration(
                    color: theme.isDark ? Color(0xff474747) : Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black12, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.devicePixelRatioOf(context) * 4.4,
                      ),
                      Icon(
                        Icons.search,
                        color: theme.isDark ? Colors.grey : Colors.white,
                      ),
                      FittedBox(
                        fit: BoxFit.cover,
                        child: Text(
                          "  Search Contacts",
                          style: TextStyle(
                              color: theme.isDark ? Colors.grey : Colors.white,
                              fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Consumer<ContactProvider>(
            builder: (BuildContext context, contact, Widget? child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: contact.contactlist.length,
                  itemBuilder: (context, index) {
                    var cl = contact.contactlist[index];
                    return ListTile(
                      leading: Stack(
                        children: [
                          CircleAvatar(
                            backgroundImage: contact.xFile != null
                                ? FileImage(
                                    File(contact.xFile!.path ?? ""),
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
                        cl.namel ?? "",
                      ),
                      subtitle: Text(
                        cl.number ?? "",
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Consumer<Themeprovider>(
        builder: (context, theme, child) => FloatingActionButton(
          backgroundColor: theme.isDark ? Colors.green : Colors.blue,
          onPressed: () {
            Navigator.pushNamed(context, "AddContact");
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
