// 
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> instruments = [
    {'image': 'assets/images/guitard.png', 'label': 'Guitar'},
    {'image': 'assets/images/keysd.png', 'label': 'Keyboard'},
    {'image': 'assets/images/guitard.png', 'label': 'Guitar'},
    {'image': 'assets/images/keysd.png', 'label': 'Keyboard'},
  ];

  final List<Map<String, String>> courses = [
    {
      'image': 'assets/images/guitard.png',
      'title': 'Vocal Classes for Beginners',
    },
    {
      'image': 'assets/images/splashscreen_img1.png',
      'title': 'Keyboard Classes for Beginners',
    },
    {
      'image': 'assets/images/guitard.png',
      'title': 'Vocal Classes for Beginners',
    },
    {
      'image': 'assets/images/splashscreen_img1.png',
      'title': 'Keyboard Classes for Beginners',
    },
  ];

  Widget _buildInstrumentItem(Map<String, String> instrument) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[800], // Fallback color
              image: instrument['image'] != null
                  ? DecorationImage(
                      image: AssetImage(instrument['image']!),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        debugPrint('Error loading image: $exception');
                      },
                    )
                  : null,
            ),
            child: instrument['image'] == null
                ? const Icon(Icons.music_note, color: Colors.white)
                : null,
          ),
          const SizedBox(height: 5),
          Text(
            instrument['label']!,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseItem(Map<String, String> course) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[800], // Fallback color
              image: course['image'] != null
                  ? DecorationImage(
                      image: AssetImage(course['image']!),
                      fit: BoxFit.cover,
                      onError: (exception, stackTrace) {
                        debugPrint('Error loading image: $exception');
                      },
                    )
                  : null,
            ),
            child: course['image'] == null
                ? const Icon(Icons.music_video, color: Colors.white, size: 40)
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF3EED9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course['title']!,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Join'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1D3C),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search ...',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Instruments row
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: instruments.length,
                  itemBuilder: (context, index) => 
                      _buildInstrumentItem(instruments[index]),
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                'Our Courses',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  itemCount: courses.length,
                  itemBuilder: (context, index) => 
                      _buildCourseItem(courses[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}