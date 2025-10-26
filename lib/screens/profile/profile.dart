import 'package:excel_learn_hub/screens/components/gradiant_color.dart';
import 'package:excel_learn_hub/screens/home/home_screen.dart';
import 'package:excel_learn_hub/screens/login&signup/toggle_screen.dart';
import 'package:excel_learn_hub/screens/profile/profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

// ----------------------------------------------------------------------
// 2. Main Stateful Widget (Handles Navigation)
// ----------------------------------------------------------------------

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [const HomeScreen(), const ProfileContent()];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Logged out successfully')));
      Get.offAll(() => const ToggleScreen());
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Logout failed: $e')));
    }
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return xcelerateGradient.createShader(bounds);
                  },
                  child: const Icon(
                    Icons.logout,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Are you sure you want to log out?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Color(0xFF6C6C6C)),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Cancel Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFFF5200)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ), // ⬆️ same height
                        ),
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return xcelerateGradient.createShader(bounds);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Logout Button
                    Expanded(
                      child: Container(
                        height: 48, // ⬆️ same visual height for both buttons
                        decoration: BoxDecoration(
                          gradient: xcelerateGradient,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _logout();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets
                                .zero, // ⬆️ remove internal padding mismatch
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        title: Row(
          children: [
            const SizedBox(width: 22),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return xcelerateGradient.createShader(bounds);
              },
              child: const Icon(Icons.menu_book, color: Colors.white),
            ),
            const SizedBox(width: 12),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return xcelerateGradient.createShader(bounds);
              },
              child: const Text(
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
            tooltip: 'Logout',
            onPressed: _showLogoutDialog, // ✅ shows themed dialog
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

// ----------------------------------------------------------------------
// 3. Custom Bottom Navigation Bar Widget (Unchanged)
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
// 4. Custom Profile Content Widget (Updated to fetch data and fix exceptions)
// ----------------------------------------------------------------------

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  late Future<List<Course>> futureCourses;
  final String apiUrl = 'https://dummyjson.com/c/cfe0-22d7-4193-b7ec';

  @override
  void initState() {
    super.initState();
    futureCourses = fetchCourses();
  }

  /// Function to fetch data from API and parse JSON
  Future<List<Course>> fetchCourses() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Decode JSON data (which is a list of maps) and map to list of Course objects
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Course.fromJson(item)).toList();
    } else {
      throw Exception(
        'Failed to load courses. Status code: ${response.statusCode}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Course>>(
      future: futureCourses,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading spinner
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Show error message
          return Center(
            child: Text('Error loading courses: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // No data case
          return const Center(child: Text('No courses found.'));
        } else {
          // Data successfully loaded
          final allCourses = snapshot.data!;
          // Filter courses based on progress and bookmark status
          final inProgressCourses = allCourses
              .where((c) => c.progress > 0 && c.progress < 1)
              .toList();
          final completedCourses = allCourses
              .where((c) => c.progress == 1.0)
              .toList();
          final bookmarkedCourses = allCourses
              .where((c) => c.isBookmarked)
              .toList();

          // FIX: Wrap the entire success content in a Material widget
          // to provide theme context for Cards, resolving the "No Material widget found" error.
          return Material(
            color: Colors.white, // Inherit the Scaffold's background color
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  // User Info Section (Using the count of loaded courses)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: const Color(0xFFE0E0E0),
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return xcelerateGradient.createShader(bounds);
                            },
                            child: const Icon(
                              Icons.person_2,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Afaq',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'afaq.official44@gmail.com',
                              style: TextStyle(color: Color(0xFF6C6C6C)),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${allCourses.length} Courses Enrolled', // Dynamic count
                              style: const TextStyle(
                                color: Color(0xFF6C6C6C),
                                fontSize: 12,
                              ),
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
                      labelPadding: const EdgeInsets.symmetric(horizontal: 7.0),
                      unselectedLabelColor: const Color(0xFF6C6C6C),
                      indicatorColor: Colors.transparent,
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: const Color.fromARGB(255, 255, 219, 199),
                      ),
                      tabs: [
                        _buildTabItem('In Progress Courses'),
                        _buildTabItem('Completed'),
                        _buildTabItem('Bookmarked'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Divider(height: 1, color: Color(0xFF6C6C6C)),

                  // Tab Bar View to display content based on tab selection
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Pass the index explicitly to avoid the DefaultTabController.of() exception
                        _buildCourseList(inProgressCourses, 0),
                        _buildCourseList(completedCourses, 1),
                        _buildCourseList(bookmarkedCourses, 2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  // Helper widget for a Tab Bar item with gradient
  Widget _buildTabItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return xcelerateGradient.createShader(bounds);
        },
        child: Tab(text: text),
      ),
    );
  }

  // Accepts the current tab index as an argument
  Widget _buildCourseList(List<Course> courses, int tabIndex) {
    if (courses.isEmpty) {
      String message;
      if (tabIndex == 0) {
        message = 'No in progress courses found.';
      } else if (tabIndex == 1) {
        message = 'No completed courses found.';
      } else {
        message = 'No bookmarked courses yet.';
      }
      return Center(child: Text(message));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return _buildCourseCard(courses[index]);
      },
    );
  }

  // Widget for a single course card
  Widget _buildCourseCard(Course course) {
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
            // Placeholder for Image/Icon
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(right: 12, top: 20),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: _buildCourseIcon(course.image), // Use helper for icon
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 'Status' Tag
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 219, 199),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return xcelerateGradient.createShader(bounds);
                        },
                        child: Text(
                          course.progress == 1.0 ? 'COMPLETED' : 'IN PROGRESS',
                          style: const TextStyle(
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
                            color: Colors.white,
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
                  const SizedBox(height: 8),
                  Text(
                    'Last Accessed: ${course.lastAccessed}',
                    style: const TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper to display an icon based on the course title/image placeholder.
  Widget _buildCourseIcon(String imageName) {
    IconData icon;
    if (imageName.contains('flutter')) {
      icon = Icons.mobile_friendly; // Flutter - Mobile App
    } else if (imageName.contains('js')) {
      icon = Icons.javascript; // JavaScript - Web/Programming
    } else if (imageName.contains('py')) {
      icon = Icons.bar_chart; // Python / Data - Analytics
    } else if (imageName.contains('node')) {
      icon = Icons.dns; // Node.js - Backend/Server
    } else if (imageName.contains('jp') || imageName.contains('java')) {
      icon = Icons.coffee; // Java - Programming
    } else if (imageName.contains('kotlin')) {
      icon = Icons.developer_mode; // Kotlin - Android Dev
    } else if (imageName.contains('swift')) {
      icon = Icons.phone_iphone; // Swift - iOS Dev
    } else if (imageName.contains('cpp')) {
      icon = Icons.code; // C++ - Programming
    } else if (imageName.contains('datavis')) {
      icon = Icons.show_chart; // Data Visualization - Charts
    } else if (imageName.contains('django')) {
      icon = Icons.storage; // Django - Backend Web
    } else {
      icon = Icons.school; // Default fallback
    }

    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return xcelerateGradient.createShader(bounds);
      },
      child: Icon(icon, size: 40, color: Colors.white),
    );
  }
}
