// ignore_for_file: file_names

import 'package:chat_app/Screens/main_body.dart';
import 'package:chat_app/Screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: buildBottomNavigationBar(),
        appBar:GradientAppBar(),
        //  AppBar(
        //   automaticallyImplyLeading: false,
        //   flexibleSpace: Container(
        //     decoration: const BoxDecoration(
        //       gradient: LinearGradient(
        //         colors: [Colors.orange , Colors.red],
        //         begin: Alignment.bottomRight,
        //         end: Alignment.topLeft
        //       )
        //     ),
        //   ),
        //   elevation: 0,
          
        //   title: const Text(
        //     "Chats",
        //     style: TextStyle(
        //         color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
        //   ),
        // ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : selectScreen());
  }

  Widget buildBottomNavigationBar() {
    final inactiveColor = Colors.grey;
    return BottomNavyBar(
        selectedIndex: index,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              icon: const Icon(Icons.apps),
              title: const Text("Home"),
              textAlign: TextAlign.center,
              activeColor: Colors.green,
              inactiveColor: inactiveColor),
          BottomNavyBarItem(
              icon: const Icon(Icons.payment),
              title: const Text('People'),
              textAlign: TextAlign.center,
              activeColor: Colors.redAccent,
              inactiveColor: inactiveColor),
          BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Text('Profile'),
              textAlign: TextAlign.center,
              activeColor: Colors.blueAccent,
              inactiveColor: inactiveColor),
        ],
        onItemSelected: (index) => setState(() => this.index = index));
  }

  Widget? selectScreen() {
    switch (index) {
      case 1:
        return const ProfileScreen();
      case 2:
        return const ProfileScreen();
      default:
        return const MainBody();
    }
  }
}
class GradientAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  GradientAppBar({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xff4338CA);
    const secondaryColor = Color(0xff6D28D9);
    return AppBar(
      title:
          const Text("Chamber", style: TextStyle(color: Colors.white)),
      backgroundColor: primaryColor,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            stops: [0.5, 1.0],
          ),
        ),
      ),
    );
  }
}
