import 'package:contact_dairy/controller/theme_provider.dart';
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
      body: Column(
        children: [
          ListTile(
            title: Text(
              "Dark Mode",
            ),
            // trailing: Consumer<Themeprovider1>(
            //   builder: (context, theme, child) {
            //     return Switch(
            //       inactiveTrackColor: Colors.black,
            //       thumbColor: MaterialStatePropertyAll(
            //           theme.isDark ? Colors.white : Colors.white),
            //       activeColor: Colors.black,
            //       value: theme.isDark,
            //       onChanged: (value) {
            //         theme.changeTheme();
            //       },
            //     );
            //   },
            // ),
          ),
          ListTile(
            title: Text("Theme"),
            trailing: Consumer<ThemeProvider>(
              builder: (BuildContext context, theme, Widget? child) {
                return DropdownButton(
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        "Light Mode",
                        style: TextStyle(color: Colors.black),
                      ),
                      value: 'light',
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "Dark Mode",
                        style: TextStyle(color: Colors.black),
                      ),
                      value: 'dark',
                    ),
                    DropdownMenuItem(
                      child: Text(
                        "System",
                        style: TextStyle(color: Colors.black),
                      ),
                      value: 'system',
                    ),
                  ],
                  value: theme.currnettheme,
                  hint: Text(
                    "Selected Theme",
                    style: TextStyle(color: Colors.black),
                  ),
                  onChanged: (String? value) {
                    // theme.currnettheme = value!;
                    theme.settheme(value ?? 'system');

                    // theme.getTheme();
                  },
                );
              },
            ),
          ),
        ],
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
