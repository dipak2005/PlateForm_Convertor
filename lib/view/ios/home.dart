import 'package:contact_dairy/controller/contactlist_provider.dart';
import 'package:contact_dairy/controller/pageprovider.dart';
import 'package:contact_dairy/controller/plateformconvter.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/contact_provider.dart';
import '../../model/contact_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Contacts",
          style: TextStyle(
              color: Color(0xff060408),
              fontSize: 25,
              fontWeight: FontWeight.w700),
        ),
        trailing: Consumer<PlateFormCovter>(
          builder: (context, plate, child) {
            return CupertinoSwitch(
              value: plate.isSwitch,
              onChanged: (value) {
                plate.plateForm();
              },
            );
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Consumer<PageProvider>(
              builder: (context, page, child) {
                return IndexedStack(
                  index: page.page,
                  children: [
                    Provider.of<ContactListProvider>(context)
                            .contactlist
                            .isNotEmpty
                        ? Consumer<ContactListProvider>(
                            builder: (context, contact, child) {
                              return SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.82,
                                child: ListView.builder(
                                  itemCount: contact.contactlist.length,
                                  itemBuilder: (context, index) {
                                    ContactModel cl =
                                        contact.contactlist[index];
                                    return CupertinoListTile(
                                      onTap: () {
                                        var uri = Uri.parse(
                                            "tel:+91${cl.number ?? ""}");
                                        launchUrl(uri);
                                      },
                                      title: Text(
                                        cl.name!,
                                      ),
                                      subtitle: Text(
                                        cl.number!,
                                      ),
                                      trailing: CupertinoButton(
                                        onPressed: () {
                                          Provider.of<ContactProvider>(context)
                                              .refresh();
                                        },
                                        child: Icon(
                                            CupertinoIcons
                                                .arrow_right_circle_fill,
                                            size: 30),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment(0, -0.8),
                                child: Icon(
                                  CupertinoIcons.person_add_solid,
                                  size:
                                      MediaQuery.of(context).devicePixelRatio *
                                          30,
                                ),
                              ),
                              Text(
                                "NO ANY Calls YET...!",
                                style: TextStyle(
                                    color: Color(0xff171DF7),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Not Any Messages Yet...!",
                            style: TextStyle(
                                color: Color(0xff171DF7),
                                fontSize:
                                    MediaQuery.of(context).devicePixelRatio *
                                        7),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            "Not Any Calls Yet...!",
                            style: TextStyle(
                                color: Color(0xff171DF7),
                                fontSize:
                                    MediaQuery.of(context).devicePixelRatio *
                                        7),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CupertinoListTile(
                          title: Text(
                            "Thememode",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
            Consumer<PageProvider>(
              builder: (BuildContext context, page, Widget? child) {
                return CupertinoTabBar(
                  items: [
                    BottomNavigationBarItem(
                      icon: CupertinoButton(
                        child: Icon(CupertinoIcons.person_add, size: 30),
                        onPressed: () {
                          page.page = 0;
                          page.prePage();
                        },
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: CupertinoButton(
                        child:
                            Icon(CupertinoIcons.chat_bubble_2_fill, size: 30),
                        onPressed: () {
                          page.page = 1;
                          page.prePage();
                        },
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: CupertinoButton(
                        child: Icon(CupertinoIcons.phone_circle_fill, size: 30),
                        onPressed: () {
                          page.page = 2;
                          page.prePage();
                        },
                      ),
                    ),
                    BottomNavigationBarItem(
                      icon: CupertinoButton(
                        child: Icon(CupertinoIcons.settings, size: 30),
                        onPressed: () {
                          page.page = 3;
                          page.prePage();
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
