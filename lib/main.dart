import 'package:contact_dairy/controller/contact_provider.dart';
import 'package:contact_dairy/controller/contactlist_provider.dart';
import 'package:contact_dairy/controller/pageprovider.dart';
import 'package:contact_dairy/controller/theme_provider.dart';
import 'package:contact_dairy/view/add_contacts.dart';
import 'package:contact_dairy/view/details.dart';
import 'package:contact_dairy/view/homepage.dart';
import 'package:contact_dairy/view/settings.dart';
import 'package:contact_dairy/view/theme/dark.dart';
import 'package:contact_dairy/view/theme/light.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return ContactProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) => ContactListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Themeprovider1(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        theme: light,
        darkTheme: dark,
        themeMode: context.watch<Themeprovider1>().themeMode,
        routes: {
          "/": (context) => Homepage(),
          "AddContact": (context) => AddContact(),
          "Settings": (context) => Settings(),
          "ShowDetails": (context) => ShowDetails(),
        },
      ),
    );
  }
}
//Provider.of<Themeprovider1>(context).themeData ==
//AppTheme.system
//? ThemeMode.system
//  : Provider.of<Themeprovider1>(context).themeData == AppTheme.light
//? ThemeMode.light
//: ThemeMode.dark,
