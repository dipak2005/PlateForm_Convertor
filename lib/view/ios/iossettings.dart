import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/contact_provider.dart';
import '../../controller/plateformconvter.dart';
import '../../controller/theme_provider.dart';

class IosSettings extends StatefulWidget {
  const IosSettings({super.key});

  @override
  State<IosSettings> createState() => _IosSettingsState();
}

class _IosSettingsState extends State<IosSettings> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CupertinoListTile(
            trailing: Consumer<PlateFormCovter>(
              builder: (BuildContext context, pa, Widget? child) {
                return CupertinoSwitch(
                  autofocus: true,
                  value: pa.ispro,
                  onChanged: (value) {
                    pa.Pro();
                  },
                );
              },
            ),
            leading: Icon(
              CupertinoIcons.person,
              color: Colors.blueAccent,
            ),
            title: Text("Profile",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
            subtitle: Text(
              "Update Profile Data",
              style: TextStyle(color: Colors.black38),
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
                      child: CupertinoButton(
                        onPressed: () {
                          Provider.of<ContactProvider>(context, listen: false)
                              .pickImage(true);
                        },
                        child: Icon(
                          CupertinoIcons.camera,
                          color:
                              Provider.of<ContactProvider>(context, listen: false)
                                          .filepath ==
                                      null
                                  ? Colors.white
                                  : Colors.transparent,
                          size: 40,
                        ),
                      ),
                      radius: 80,
                      backgroundImage:
                          Provider.of<ContactProvider>(context).filepath != null
                              ? FileImage(File(
                                  Provider.of<ContactProvider>(context)
                                          .filepath ??
                                      ""))
                              : null,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).width / 3),
                      child: CupertinoTextFormFieldRow(
                        placeholder: "Enter Your Name...",
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.blueAccent,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.sizeOf(context).width / 3),
                      child: CupertinoTextFormFieldRow(
                        placeholder: "Enter Your Bio",
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.blueAccent,
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
          CupertinoListTile(
            trailing: Consumer<ThemeProvider>(
              builder: (BuildContext context, theme, Widget? child) {
                return CupertinoSwitch(
                  autofocus: true,
                  value: theme.isDark,
                  onChanged: (value) {
                    theme.iosTheme();
                  },
                );
              },
            ),
            leading: Icon(
              CupertinoIcons.person,
              color: Colors.blueAccent,
            ),
            title: Text("Thememode",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
            subtitle: Text(
              "Update Theme Data",
              style: TextStyle(color: Colors.black38),
            ),
          ),
          // CupertinoListTile(
          //   title: Text("Theme"),
          //   trailing: Consumer<ThemeProvider>(
          //     builder: (BuildContext context, theme, Widget? child) {
          //       return DropdownButton(
          //         items: [
          //           DropdownMenuItem(
          //             child: Text(
          //               "Light Mode",
          //               style: TextStyle(color: Colors.black),
          //             ),
          //             value: 'light',
          //           ),
          //           DropdownMenuItem(
          //             child: Text(
          //               "Dark Mode",
          //               style: TextStyle(color: Colors.black),
          //             ),
          //             value: 'dark',
          //           ),
          //           DropdownMenuItem(
          //             child: Text(
          //               "System",
          //               style: TextStyle(color: Colors.black),
          //             ),
          //             value: 'system',
          //           ),
          //         ],
          //         value: theme.currnettheme,
          //         hint: Text(
          //           "Selected Theme",
          //           style: TextStyle(color: Colors.black),
          //         ),
          //         onChanged: (String? value) {
          //           // theme.currnettheme = value!;
          //           theme.settheme(value ?? 'system');
          //
          //           // theme.getTheme();
          //         },
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
