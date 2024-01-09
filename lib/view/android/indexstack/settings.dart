import 'dart:io';

import 'package:contact_dairy/controller/contact_provider.dart';
import 'package:contact_dairy/controller/pageprovider.dart';
import 'package:contact_dairy/controller/plateformconvter.dart';
import 'package:contact_dairy/controller/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  // int? dropdown;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.person_2_outlined),
              title: Text(
                "Profile",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 20),
              ),
              trailing: Consumer<PlateFormCovter>(
                builder: (BuildContext context, pa, Widget? child) {
                  return Switch(
                    autofocus: true,
                    value: pa.ispro,
                    activeTrackColor: Colors.black38,
                    activeColor: Colors.white,
                    inactiveTrackColor: Colors.black38,
                    inactiveThumbColor: Colors.white,
                    onChanged: (value) {
                      pa.Pro();
                    },
                  );
                },
              ),
            ),
            if (Provider.of<PlateFormCovter>(context).ispro)
              Container(
                height: MediaQuery.sizeOf(context).height * 0.4,
                width: MediaQuery.sizeOf(context).width,
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: IconButton(
                          onPressed: () {
                            Provider.of<ContactProvider>(context, listen: false)
                                .pickImage(true);
                          },
                          icon: Icon(
                            Icons.person,
                            color: Provider.of<ContactProvider>(context,
                                            listen: false)
                                        .filepath ==
                                    null
                                ? Colors.white
                                : Colors.transparent,
                            size: 30,
                          ),
                        ),
                        radius: 60,
                        backgroundImage:
                            Provider.of<ContactProvider>(context).filepath !=
                                    null
                                ? FileImage(File(
                                    Provider.of<ContactProvider>(context)
                                            .filepath ??
                                        ""))
                                : null,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.sizeOf(context).width / 3),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          cursorColor: Colors.blueAccent,
                          decoration: InputDecoration(
                            hintText: "Enter Your Name...",
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.sizeOf(context).width / 3),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          cursorColor: Colors.blueAccent,
                          decoration:
                              InputDecoration(hintText: "Enter Your Bio..."),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Save",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Cancel",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            Consumer<ThemeProvider>(
              builder: (context, theme, child) {
                return ListTile(
                  title: Text("Theme Mode"),
                  leading: Icon(Icons.light),
                  trailing: Consumer<ThemeProvider>(
                    builder: (BuildContext context, theme, child) {
                      return DropdownButton(
                        items: const [
                          DropdownMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.phone_android_outlined),
                                Text(
                                  "System",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.light_mode_rounded),
                                Text(
                                  "Light Mode",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.dark_mode),
                                Text(
                                  "Dark Mode",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            value: 2,
                          ),
                        ],
                        value: theme.currnettheme,
                        hint: Text(
                          "Selected Theme",
                          style: TextStyle(color: Colors.black),
                        ),
                        onChanged: (int? value) {
                          // theme.currnettheme = value!;
                          theme.settheme(value ?? 0);

                          // theme.getTheme();
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
/*

 Consumer<Themeprovider1>(
              builder: (context, theme, child) => DropdownButton<AppTheme>(
                items: AppTheme.values.map(
                  (theme) {
                    var tm = Provider.of<Themeprovider1>(context, listen: false)
                            .themeData ==
                        AppTheme.dark;
                    return DropdownMenuItem<AppTheme>(
                      value: theme,
                      child: Text(
                        // theme.toString().split(".").last,
                        theme.name,
                        style: TextStyle(
                          color: tm ? Colors.white : Colors.black,
                        ),
                      ),
                    );
                  },
                ).toList(),
                value: Provider.of<Themeprovider1>(context, listen: false)
                    .themeData,
                onChanged: (value) {
                  Provider.of<Themeprovider1>(context, listen: false)
                      .setTheme(value!);
                },
                hint: Text(
                  "Select Theme",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),


 */
