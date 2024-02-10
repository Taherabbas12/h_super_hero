import 'package:flutter/material.dart';
import 'package:h_super_hero/colors_app.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

import '../request/viewRequets.dart';
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
  }

  List<Widget> view = [
    const Home(),
    Category(),
    ViewRequest(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: view[_selectedIndex]),
      bottomNavigationBar: ResponsiveNavigationBar(
        selectedIndex: _selectedIndex,

        onTabChange: changeTab,
        // showActiveButtonText: false,
        textStyle: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),

        navigationBarButtons: [
          NavigationBarButton(
              text: 'Home', icon: Icons.home, backgroundColor: primaryColorCo),
          NavigationBarButton(
              text: 'Category',
              icon: Icons.category_outlined,
              backgroundColor: primaryColorCo),
          NavigationBarButton(
              text: 'Request',
              icon: Icons.watch_later_outlined,
              backgroundColor: primaryColorCo),
          NavigationBarButton(
              text: 'profile',
              icon: Icons.person,
              backgroundColor: primaryColorCo),
        ],
      ),
    );
  }
}
