import 'package:excel_learn_hub/screens/components/gradiant_color.dart';
import 'package:excel_learn_hub/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

// ----------------------------------------------------------------------
// 1. Data Model & Dummy Pages
// ----------------------------------------------------------------------

class CourseProgress {
  final String title;
  final String category;
  final int completedLessons;
  final int totalLessons;
  final double progress;
  final String lastAccessed;
  final AssetImage image;

  const CourseProgress({
    required this.title,
    required this.category,
    required this.completedLessons,
    required this.totalLessons,
    required this.progress,
    required this.lastAccessed,
    required this.image,
  });
}

// ----------------------------------------------------------------------
// 2. Main Stateful Widget (Handles Navigation)
// ----------------------------------------------------------------------

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Index 0: Home, Index 1: Profile (Starts on Profile as per the image)
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    _ProfileContent(), // The custom profile page is placed here
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        title: Row(
          children: [
            SizedBox(width: 22),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return xcelerateGradient.createShader(bounds);
              },
              child: Icon(Icons.menu_book, color: Colors.white),
            ),
            SizedBox(width: 8),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return xcelerateGradient.createShader(bounds);
              },
              child: Text(
                'Excel LearnHub',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black87),
            onPressed: () {},
            tooltip: 'Logout',
          ),
          const SizedBox(width: 10),
        ],
      ),

      // Display the selected page in the body
      body: _pages[_currentIndex],

      // --- CUSTOM BOTTOM NAVIGATION BAR ---
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

// ----------------------------------------------------------------------
// 3. Custom Bottom Navigation Bar Widget
// ----------------------------------------------------------------------

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // The large rounded background container
      height: 65, // Adjusted for a cleaner look
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          // Subtle shadow for depth
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [_buildNavItem(0, 'Home'), _buildNavItem(1, 'Profile')],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label) {
    // Colors from the image: selected is purple/blue, unselected is gray/black
    final bool isSelected = index == currentIndex;
    final Color selectedColor = const Color(0xFF6C6C6C);
    final Color unselectedColor = Colors.black87;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? selectedColor : unselectedColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          // The small indicator line below the selected label
          if (isSelected)
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return xcelerateGradient.createShader(bounds);
              },
              child: Container(
                width: 30, // Fixed width for the line
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white, // Purple color from the image
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          // Add a placeholder height for unselected items to prevent layout shift
          if (!isSelected)
            const SizedBox(
              height: 8,
            ), // 4 (SizedBox) + 4 (Container height) = 8
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------
// 4. Custom Profile Content Widget (The original stateless content)
// ----------------------------------------------------------------------

class _ProfileContent extends StatelessWidget {
  const _ProfileContent(); // Use the default constructor

  // Sample data for the courses (moved from the original StatelessWidget)
  final List<CourseProgress> _inProgressCourses = const [
    CourseProgress(
      title: 'Flutter Mobile Development',
      category: 'Mobile Development',
      completedLessons: 2,
      totalLessons: 12,
      progress: 0.16,
      lastAccessed: '2 hours ago',
      image: AssetImage('assets/images/flutter_logo.png'),
    ),
    CourseProgress(
      title: 'JavaScript Fundamentals',
      category: 'Programming Languages',
      completedLessons: 10,
      totalLessons: 20,
      progress: 0.50,
      lastAccessed: '1 day ago',
      image: AssetImage('assets/images/js_logo.png'),
    ),
    CourseProgress(
      title: 'Java Programming Complete Course',
      category: 'Programming Languages',
      completedLessons: 19,
      totalLessons: 25,
      progress: 0.76,
      lastAccessed: '3 days ago',
      image: AssetImage('assets/images/jp_logo.png'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          // User Info Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(
                    0xFFE0E0E0,
                  ), // Lighter color for avatar bg
                  child: Icon(Icons.person_2, size: 40, color: Colors.white),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Aimen',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'aimen@email.example.com',
                      style: TextStyle(color: Color(0xFF6C6C6C)),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '3 Courses Enrolled',
                      style: TextStyle(color: Color(0xFF6C6C6C), fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tab Bar for course status
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              labelPadding: EdgeInsets.symmetric(horizontal: 7.0),
              unselectedLabelColor: Color(0xFF6C6C6C),
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  12,
                ), // Rounded corners for indicator
                color: Color.fromARGB(
                  255,
                  255,
                  219,
                  199,
                ), // Light background for selected tab
              ),
              tabs: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return xcelerateGradient.createShader(bounds);
                    },
                    child: Tab(text: 'In Progress Courses'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return xcelerateGradient.createShader(bounds);
                    },
                    child: Tab(text: 'Completed'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return xcelerateGradient.createShader(bounds);
                    },
                    child: Tab(text: 'Bookmarked'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const Divider(height: 1, color: Color(0xFF6C6C6C)),

          // Tab Bar View to display content based on tab selection
          Expanded(
            child: TabBarView(
              children: [
                _buildCourseList(_inProgressCourses),
                const Center(child: Text('No completed courses found.')),
                const Center(child: Text('No bookmarked courses yet.')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build the list of course cards (remains the same)
  Widget _buildCourseList(List<CourseProgress> courses) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return _buildCourseCard(courses[index]);
      },
    );
  }

  // Widget for a single course card (remains the same, styling adjusted slightly)
  Widget _buildCourseCard(CourseProgress course) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFF6C6C6C), width: 0.2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder Image/Icon
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(right: 12, top: 20),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Image(image: course.image),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 'In Progress' Tag
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 219, 199),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return xcelerateGradient.createShader(bounds);
                        },
                        child: Text(
                          'IN PROGRESS',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Course Title
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Course Category
                  Text(
                    course.category,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),

                  const SizedBox(height: 8),

                  // Progress Text and Bar
                  Text(
                    '${course.completedLessons} of ${course.totalLessons} lessons completed',
                    style: const TextStyle(fontSize: 12),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return xcelerateGradient.createShader(bounds);
                          },
                          child: LinearProgressIndicator(
                            value: course.progress,
                            backgroundColor: Colors.transparent,
                            color: Colors.white, // Using blue for consistency
                            minHeight: 5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return xcelerateGradient.createShader(bounds);
                        },
                        child: Text(
                          '${(course.progress * 100).toInt()}%',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
