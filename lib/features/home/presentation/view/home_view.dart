import 'package:flutter/material.dart';
import 'package:batch34_b/core/common/card/course_card.dart';
import 'package:batch34_b/features/course/domain/entity/course_entity.dart';
import 'package:batch34_b/features/lesson/presentation/view/lesson_view.dart'; // <-- Make sure this import is correct

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<CourseEntity> _allCourses = [
    CourseEntity(
      id: '1',
      name: 'Guitar Basics',
      totalPrice: 29.99,
      filepath: 'assets/images/guitard.jpg',
    ),
    CourseEntity(
      id: '2',
      name: 'Piano Mastery',
      totalPrice: 49.99,
      filepath: 'assets/images/piano.jpg',
    ),
  ];

  List<CourseEntity> _filteredCourses = [];
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Guitar',
    'Piano',
    'Drums',
    'Vocal',
    'Production',
  ];

  @override
  void initState() {
    super.initState();
    _filteredCourses = List.from(_allCourses);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  void _onSearch(String query) {
    setState(() {
      _filteredCourses =
          _allCourses.where((course) {
            return course.name.toLowerCase().contains(query.toLowerCase()) &&
                (_selectedCategory == 'All' ||
                    course.name.toLowerCase().contains(
                      _selectedCategory.toLowerCase(),
                    ));
          }).toList();
    });
  }

  void _onCategoryChanged(String category) {
    setState(() {
      _selectedCategory = category;
      _onSearch(_searchController.text);
    });
  }

  void _onClearSearch() {
    _searchController.clear();
    _onSearch('');
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color(0xFF222740);
    const lavender = Color(0xFFEDE7F6);
    const pinkAccent = Color(0xFFF8BBD0);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                expandedHeight: 120,
                pinned: true,
                backgroundColor: darkBlue,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 20),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Your space, Your Pace',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Your PASSION.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Keep Growing',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Search Bar & Explore Banner & Categories & Popular Courses Headers all in SliverToBoxAdapters
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: _buildSearchBar(darkBlue),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildExploreBanner(
                    darkBlue,
                    lavender,
                    pinkAccent,
                    context,
                  ),
                ),
              ),

              SliverToBoxAdapter(child: const SizedBox(height: 30)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(child: const SizedBox(height: 15)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: _buildCategoryChips(darkBlue),
                ),
              ),

              SliverToBoxAdapter(child: const SizedBox(height: 25)),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Popular Courses',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: darkBlue,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // TODO: Implement "See All" action
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(
                            color: darkBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(child: const SizedBox(height: 10)),

              // Courses list or empty state
              if (_filteredCourses.isEmpty)
                SliverToBoxAdapter(child: _buildEmptyState())
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final course = _filteredCourses[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 4,
                      ),
                      child: CourseCard(
                        course: course,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LessonView(),
                            ),
                          );
                        },
                      ),
                    );
                  }, childCount: _filteredCourses.length),
                ),

              SliverToBoxAdapter(child: const SizedBox(height: 20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(Color darkBlue) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearch,
        decoration: InputDecoration(
          hintText: 'Search for courses, instruments...',
          prefixIcon: Icon(Icons.search, color: darkBlue),
          suffixIcon:
              _searchController.text.isNotEmpty
                  ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: _onClearSearch,
                  )
                  : Icon(Icons.tune, color: darkBlue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildExploreBanner(
    Color darkBlue,
    Color lavender,
    Color pinkAccent,
    BuildContext context,
  ) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [pinkAccent.withOpacity(0.8), lavender.withOpacity(0.9)],
        ),
        boxShadow: [
          BoxShadow(
            color: pinkAccent.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              Icons.music_note,
              size: 120,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '🎵 Start Your Musical Journey',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 20, 47, 69),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Join thousands of students learning music online',
                  style: TextStyle(
                    fontSize: 14,
                    color: darkBlue.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LessonView()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Explore Now',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips(Color darkBlue) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (_) => _onCategoryChanged(category),
              backgroundColor: Colors.white,
              selectedColor: darkBlue,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : darkBlue,
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? darkBlue : Colors.grey.shade300,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Icon(Icons.music_off, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 20),
          Text(
            'No courses found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or browse different categories',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _onClearSearch();
              _onCategoryChanged('All');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 13, 14, 73),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }
}
