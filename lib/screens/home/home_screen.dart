// lib/screens/home/home_screen.dart
import 'package:excel_learn_hub/screens/components/gradiant_color.dart';
import 'package:excel_learn_hub/screens/details/course_detail.logic.dart';
import 'package:excel_learn_hub/screens/profile/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../details/course_detail.view.dart'; 
import 'course_card.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String apiUrl = 'https://dummyjson.com/c/cfe0-22d7-4193-b7ec';
  late Future<List<Course>> futureCourses;

  final TextEditingController _searchController = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;

  List<Course> allCourses = [];
  List<Course> filteredCourses = [];
  String selectedCategory = 'All';
  Set<String> categories = {'All'};

  // This set will track bookmarked titles for state management
  final Set<String> bookmarkedTitles = {};
  String username = "Afaq";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    futureCourses = _fetchCourses();
    _searchController.addListener(_filterCourses);
  }

  // --- API FETCH FUNCTION ---
  Future<List<Course>> _fetchCourses() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);

      // Initialize allCourses and bookmarkedTitles from API data
      allCourses = jsonData.map((item) => Course.fromJson(item)).toList();
      categories.addAll(allCourses.map((c) => c.category).toSet());

      for (var course in allCourses) {
        if (course.isBookmarked) {
          bookmarkedTitles.add(course.title);
        }
      }

      // Initial filter to show all courses
      _filterCourses();
      return allCourses;
    } else {
      throw Exception('Failed to load courses from API.');
    }
  }

  // --- FILTERING LOGIC ---
  void _filterCourses() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCourses = allCourses.where((course) {
        final matchesCategory =
            selectedCategory == 'All' || course.category == selectedCategory;
        final matchesSearch = course.title.toLowerCase().contains(query);
        return matchesCategory && matchesSearch;
      }).toList();
    });
  }

  void _onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
    _filterCourses();
  }

  void _toggleBookmark(String title) {
    setState(() {
      final course = allCourses.firstWhere((c) => c.title == title);
      course.isBookmarked = !course.isBookmarked;

      if (course.isBookmarked) {
        bookmarkedTitles.add(title);
      } else {
        bookmarkedTitles.remove(title);
      }
    });
  }

  // --- SPEECH-TO-TEXT LOGIC ---
  Future<void> _listen() async {
    // ... (Your speech-to-text logic remains the same)
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) {
            setState(() {
              _searchController.text = val.recognizedWords;
              _filterCourses();
            });
          },
          localeId: 'en_US',
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Course>>(
      future: futureCourses,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error loading courses: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No courses found.'));
        } else {
          // Data is loaded, wrap in Material for context
          return Material(color: Colors.white, child: _buildHomeContent());
        }
      },
    );
  }

  // --- MAIN CONTENT BUILDER ---
  Widget _buildHomeContent() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome message and tagline
          Text(
            'Welcome, $username 👋',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            'Continue your learning journey!',
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 16),

          // Search bar with mic button
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for courses...',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    prefixIcon: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return xcelerateGradient.createShader(bounds);
                      },
                      child: const Icon(Icons.search, color: Colors.white),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0.0,
                      horizontal: 0.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Mic Button
              CircleAvatar(
                radius: 24,
                backgroundColor: _isListening
                    ? const Color.fromARGB(255, 255, 219, 199)
                    : Colors.grey.shade200,
                child: IconButton(
                  icon: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return xcelerateGradient.createShader(bounds);
                    },
                    child: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      // The color here is only needed for ShaderMask coloring
                      color: _isListening ? Colors.white : Colors.black54,
                    ),
                  ),
                  onPressed: _listen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Category filter chips
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((cat) {
                final isSelected = cat == selectedCategory;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    // FIX: Gradient applied to the Text widget
                    label: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return xcelerateGradient.createShader(bounds);
                            },
                            child: Text(cat),
                          ),
                    selected: isSelected,
                    onSelected: (_) => _onCategorySelected(cat),
                    selectedColor: const Color.fromARGB(255, 255, 219, 199),
                    backgroundColor: Colors.grey.shade200,
                    labelStyle: TextStyle(
                      // FIX: Text is white when selected
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          // Added section title for clarity
          const Text(
            'Recommended Courses',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Course list - GridView
          Expanded(
            child: filteredCourses.isEmpty
                ? const Center(child: Text('No courses found for this filter.'))
                : GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 1.0,
                        ),
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) {
                      final course = filteredCourses[index];
                      return CourseCard(
                        title: course.title,
                        level: course.level,
                        lessons: course.lessons,
                        hours: course.hours,
                        progress: course.progress,
                        // Use the state-tracked set for the bookmarked status
                        isBookmarked: bookmarkedTitles.contains(course.title),
                        image: course.image,
                        onTap: () {
                          // Navigate to Course Details
                          Get.to(
                            () => CourseDetailsView(
                              // Inject the CourseDetailsLogic with the specific course ID
                              logic: Get.put(
                                CourseDetailsLogic(courseId: course.id),
                                tag: 'course_${course.id}',
                              ),
                            ),
                            // Optional: Give the route a name for easy debugging
                            routeName: '/course_detail',
                          );
                        },
                        onBookmarkToggle: () => _toggleBookmark(course.title),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
