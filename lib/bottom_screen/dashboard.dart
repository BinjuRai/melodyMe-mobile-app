import 'package:batch34_b/bottom_screen/explore.dart';
import 'package:batch34_b/bottom_screen/home.dart';
import 'package:batch34_b/bottom_screen/mycourse.dart';
import 'package:batch34_b/bottom_screen/profile.dart';

import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  List<Widget> lstBottomScreen = [
    const HomeScreen(),
    const ExploreScreen(),
    const Mycourse(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MelodyMe',
          style: TextStyle(fontFamily: 'Bagel_Fat_One', fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music, size: 26.0),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chrome_reader_mode, size: 26.0),
            label: 'My courses',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        backgroundColor: const Color.fromARGB(255, 11, 27, 42),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 236, 194, 194),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
