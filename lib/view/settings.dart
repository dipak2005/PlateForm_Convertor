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
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(
              "Dark Mode",
            ),
            trailing: Consumer<Themeprovider>(
              builder: (context, theme, child) {
                return Switch(
                  inactiveTrackColor: Colors.black,
                  thumbColor: MaterialStatePropertyAll(
                      theme.isDark ? Colors.white : Colors.white),
                  activeColor: Colors.black,
                  value: theme.isDark,
                  onChanged: (value) {
                    theme.changeTheme();
                  },
                );
              },
            ),
          ),
          ListTile(
            title: Text("Theme"),
            trailing: Consumer<Themeprovider>(
              builder: (context, theme, child) => DropdownButton(
                items: [
                  DropdownMenuItem(
                    child: Text(
                      "Light",
                      style: TextStyle(color: Colors.black),
                    ),
                    value: 0,
                    onTap: () {
                      theme.light();
                    },
                  ),
                  DropdownMenuItem(
                    child: Text(
                      "Dark",
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      theme.dark();
                    },
                    value: 1,
                  ),
                ],
                value: theme.dropdown,
                onChanged: (value) {
                  theme.dropdown = value;

                  theme.light();
                  theme.dark();
                },
                hint: Text(
                  "Select Theme",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
