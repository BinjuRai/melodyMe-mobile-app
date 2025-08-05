import 'package:batch34_b/core/common/sensor/themeviewmodel/theme_bloc.dart';
import 'package:batch34_b/core/common/sensor/themeviewmodel/theme_event.dart';
import 'package:batch34_b/features/auth/data/repository/user_repository_impl.dart';
import 'package:batch34_b/features/auth/presentation/view/profile_view.dart';
import 'package:batch34_b/features/home/presentation/view/home_view.dart';
import 'package:batch34_b/features/notification/presentation/view/notification_screen.dart';
import 'package:flutter/material.dart';

import 'package:batch34_b/features/course/presentation/view/ courselistpage_view.dart';
import 'package:batch34_b/features/lesson/presentation/view/lesson_view.dart';
import 'package:batch34_b/features/wishlist/presentation/view/wishlist_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const CourseListPage(),
    const LessonView(),
    const ViewWishlistPage(userId: ''),
  ];

  final List<String> _titles = [
    'MelodyMe',
    'My Courses',
    'Lessons',
    'Wishlist',
  ];

  @override
  Widget build(BuildContext context) {
    final Color iconColor =
        Colors.white; // Ensure contrast with dark background

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 11, 27, 42),
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(
            fontFamily: 'Bagel_Fat_One',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: iconColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NotificationScreen(userId: ''),
                ),
              );
            },
          ),

          // IconButton(
          //   icon: Icon(Icons.person, color: iconColor),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (_) => ProfileView()),
          //     );
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.person, color: iconColor),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          ProfileProvider(userRepository: UserRepositoryImpl()),
                ),
              );
            },
          ),

          /// 🚨 Only show this button on iOS for debugging (you can remove this in production)
          if (Theme.of(context).platform == TargetPlatform.iOS)
            IconButton(
              icon: Icon(Icons.brightness_6, color: Colors.amberAccent),
              tooltip: 'Toggle Theme (Sim)',
              onPressed: () {
                context.read<ThemeBloc>().add(ToggleThemeEvent());
              },
            ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 11, 27, 42),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 236, 194, 194),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.chrome_reader_mode),
            label: 'My Courses',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Lessons'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
        ],
      ),
    );
  }
}

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           _titles[_selectedIndex],
//           style: const TextStyle(fontFamily: 'Bagel_Fat_One', fontSize: 20),
//         ),
//         centerTitle: true,
//       ),
//       body: _screens[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: const Color.fromARGB(255, 11, 27, 42),
//         selectedItemColor: Colors.white,
//         unselectedItemColor: const Color.fromARGB(255, 236, 194, 194),
//         currentIndex: _selectedIndex,
//         onTap: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.chrome_reader_mode),
//             label: 'My Courses',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Lessons'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Wishlist',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//         ],
//       ),
//     );
//   }
// }
