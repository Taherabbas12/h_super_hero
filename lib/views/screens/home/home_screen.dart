import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:h_super_hero/colors_app.dart';

import '../request/viewRequets.dart';
import '../welconm_screen.dart';
import 'category.dart';
import 'home.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void changeTab(int index) {
    _selectedIndex = index;
    setState(() {
      print(_selectedIndex);
    });
    Navigator.pop(context);
  }

  List<WidgetName> view = [
    WidgetName(Home(), 'Home', Icons.home),
    WidgetName(Category(), 'Category', Icons.category_outlined),
    WidgetName(ViewRequest(), 'Request', Icons.watch_later_outlined),
    WidgetName(Profile(), 'Profile', Icons.person)
  ];
  ProfileData2? profileDataView2;
  ProfileData? profileDataView;
  @override
  Widget build(BuildContext context) {
    if (GetStorage().read('color') == "customers") {
      profileDataView = ProfileData.fromMap(GetStorage().read('auth'));
    } else {
      try {
        profileDataView2 = ProfileData2.fromMap(GetStorage().read('auth'));
      } catch (e) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WelcoomeScreen(),
            ));
      }
    }
    return Scaffold(
      body: SafeArea(child: view[_selectedIndex].body),
      appBar: AppBar(),

      drawer: Drawer(
        //
        child: Column(
          children: [
            GetStorage().read('color') == "customers"
                ? UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: primaryColorCo),
                    currentAccountPicture: CircleAvatar(
                        backgroundImage: AssetImage(profileDataView!.gender == 1
                            ? 'assets/male.png'
                            : 'assets/female.png')),
                    accountName: Text(profileDataView!.name),
                    accountEmail: Text(profileDataView!.email))
                : UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: primaryColorCo),
                    currentAccountPicture: const CircleAvatar(
                        backgroundImage: AssetImage('assets/female.png')),
                    accountName: Text(profileDataView2!.name),
                    accountEmail: Text(profileDataView2!.email)),

            //
            for (int i = 0; i < view.length; i++)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 5),
                child: ListTile(
                  leading: Icon(
                    view[i].iconData,
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  title: Text(
                    view[i].name,
                    style: const TextStyle(color: Colors.white),
                  ),
                  tileColor: i == _selectedIndex
                      ? primaryColorCo
                      : primaryColorCo.withOpacity(0.7),
                  onTap: () {
                    //
                    changeTab(i);
                  },
                ),
              )
          ],
        ),
      ),

      // bottomNavigationBar: ResponsiveNavigationBar(
      //   selectedIndex: _selectedIndex,

      //   onTabChange: changeTab,
      //   // showActiveButtonText: false,
      //   textStyle: TextStyle(
      //     color: textColor,
      //     fontWeight: FontWeight.bold,
      //   ),

      //   navigationBarButtons: [
      //     NavigationBarButton(
      //         text: 'Home', icon: Icons.home, backgroundColor: primaryColorCo),
      //     NavigationBarButton(
      //         text: 'Category',
      //         icon: Icons.category_outlined,
      //         backgroundColor: primaryColorCo),
      //     NavigationBarButton(
      //         text: 'Request',
      //         icon: Icons.watch_later_outlined,
      //         backgroundColor: primaryColorCo),
      //     NavigationBarButton(
      //         text: 'profile',
      //         icon: Icons.person,
      //         backgroundColor: primaryColorCo),
      //   ],
      // ),
    );
  }
}

class WidgetName {
  String name;
  Widget body;
  IconData iconData;
  WidgetName(this.body, this.name, this.iconData);
}
