// import 'package:flutter/material.dart';

// class HomeView extends StatefulWidget {
//   const HomeView({super.key});

//   @override
//   State<HomeView> createState() => _HomeViewState();
// }

// class _HomeViewState extends State<HomeView> {
//   final List<Map<String, String>> instruments = [
//     {'image': 'assets/images/guitard.png', 'label': ''},
//     {'image': 'assets/images/keysd.png', 'label': 'Keyboard'},
//     {'image': 'assets/images/guitard.png', 'label': 'Guitar'},
//     {'image': 'assets/images/keysd.png', 'label': 'Keyboard'},
//   ];

//   final List<Map<String, String>> courses = [
//     {'image': 'assets/mic.png', 'title': 'Vocal Classes for Beginners'},
//     {
//       'image': 'assets/images/splashscreen_img1.png',
//       'title': 'Keyboard Classes for Beginners',
//     },
//     {'image': 'assets/images/mic.png', 'title': 'Vocal Classes for Beginners'},
//     {
//       'image': 'assets/images/splashscreen_img1.png',
//       'title': 'Keyboard Classes for Beginners',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFF1B1D3C),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // App bar
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'MelodyMe',
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontFamily: 'Comic Sans MS',
//                     ),
//                   ),
//                   Icon(Icons.menu, color: Colors.white),
//                 ],
//               ),
//               SizedBox(height: 16),

//               // Search bar
//               TextField(
//                 decoration: InputDecoration(
//                   hintText: 'Search ...',
//                   fillColor: Colors.white,
//                   filled: true,
//                   contentPadding: EdgeInsets.symmetric(horizontal: 20),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),

//               // Instruments row
//               SizedBox(
//                 height: 100,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: instruments.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(right: 10),
//                       child: Column(
//                         children: [
//                           Container(
//                             width: 60,
//                             height: 60,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               image: DecorationImage(
//                                 image: AssetImage(instruments[index]['image']!),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 5),
//                           Text(
//                             instruments[index]['label']!,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),

//               Text(
//                 'Our Courses',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 10),

//               Expanded(
//                 child: ListView.builder(
//                   itemCount: courses.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 16),
//                       child: Row(
//                         children: [
//                           Container(
//                             width: 100,
//                             height: 100,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               image: DecorationImage(
//                                 image: AssetImage(courses[index]['image']!),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                           Expanded(
//                             child: Container(
//                               padding: EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 color: Color(0xFFF3EED9),
//                                 borderRadius: BorderRadius.circular(16),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     courses[index]['title']!,
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   SizedBox(height: 8),
//                                   Align(
//                                     alignment: Alignment.bottomRight,
//                                     child: ElevatedButton(
//                                       onPressed: () {},
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: Colors.white,
//                                         foregroundColor: Colors.black,
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 20,
//                                         ),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(
//                                             20,
//                                           ),
//                                         ),
//                                       ),
//                                       child: Text('Join'),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:batch34_b/core/common/card/course_card.dart';
import 'package:batch34_b/features/course/domain/entity/course_entity.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();

  // Mock data for courses
  final List<CourseEntity> _allCourses = [];

  List<CourseEntity> _filteredCourses = [];

  @override
  void initState() {
    super.initState();
    _filteredCourses = List.from(_allCourses);
  }

  void _onSearch(String query) {
    setState(() {
      _filteredCourses =
          _allCourses
              .where(
                (course) =>
                    course.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  void _onClearSearch() {
    _searchController.clear();
    _onSearch('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 🔍 Search Bar
          TextField(
            controller: _searchController,
            onChanged: _onSearch,
            decoration: InputDecoration(
              hintText: 'Search courses...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _onClearSearch,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 🎵 Banner
          Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage(
                  'assets/images/guitard.jpg',
                ), // Update your asset path
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),

          if (_filteredCourses.isEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 32),
              child: Center(
                child: Text(
                  'No courses found.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const _CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      backgroundColor: Colors.deepPurple,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
