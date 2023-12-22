import 'package:contact_dairy/controller/contact_provider.dart';
import 'package:contact_dairy/controller/theme_provider.dart';
import 'package:contact_dairy/view/add_contacts.dart';
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
          create: (context) => Themeprovider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        initialRoute: "/",
        debugShowCheckedModeBanner: false,
        theme: light,
        darkTheme: dark,
        themeMode: Provider.of<Themeprovider>(context).isDark
            ? ThemeMode.dark
            : Provider.of<Themeprovider>(context).isLight
                ? ThemeMode.light
                : ThemeMode.system,
        routes: {
          "/": (context) => const Homepage(),
          "AddContact": (context) => const AddContact(),
          "Settings": (context) => Settings(),
        },
      ),
    );
  }
}
