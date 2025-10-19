import 'package:excel_learn_hub/screens/components/gradiant_color.dart';
import 'package:excel_learn_hub/screens/details/course_detail.view.dart';
import 'package:excel_learn_hub/screens/home/course_card.dart';
import 'package:excel_learn_hub/screens/home/dummy_courses.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;

  List<Map<String, dynamic>> filteredCourses = [];
  String selectedCategory = 'All';
  Set<String> categories = {'All'};

  final Set<String> bookmarkedCourses = {};
  String username = "Hifsa"; // This should be dynamically fetched if needed

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    categories.addAll(dummyCourses.map((c) => c['category'] as String).toSet());
    filteredCourses = List.from(dummyCourses);
    _searchController.addListener(_filterCourses);
  }

  void _filterCourses() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCourses = dummyCourses.where((course) {
        final matchesCategory = selectedCategory == 'All' || course['category'] == selectedCategory;
        final matchesSearch = course['title'].toLowerCase().contains(query);
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
      if (bookmarkedCourses.contains(title)) {
        bookmarkedCourses.remove(title);
      } else {
        bookmarkedCourses.add(title);
      }
    });
  }

  Future<void> _listen() async {
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
    return _buildHomeContent();
  }

  Widget _buildHomeContent() {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome message and tagline
          Text(
            'Welcome, $username 👋',
            // Matched to the bold text in the Profile screen
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), 
          ),
          const SizedBox(height: 4),
          Text(
            'Continue your learning journey!',
            // Matched to the muted text color
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
  },child: Icon(Icons.search, color: Colors.white)),
                    // Matched the seamless, rounded look of the Profile UI
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none, // Removes the standard outline border
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Mic Button
              CircleAvatar(
                radius: 24,
                // Use the primary accent color when listening
                backgroundColor: _isListening ? Color.fromARGB(255, 255, 219, 199) : Colors.grey.shade200, 
                child: IconButton(
                  icon: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: _isListening ? Colors.white : Colors.black54,
                  ),
                  onPressed: _listen,
                ),
              )
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
                    label: ShaderMask(
  shaderCallback: (Rect bounds) {
    return xcelerateGradient.createShader(bounds);
  },child: Text(cat)),
                    selected: isSelected,
                    onSelected: (_) => _onCategorySelected(cat),
                    // Use the primary accent color for selection
                    selectedColor: Color.fromARGB(255, 255, 219, 199), 
                    backgroundColor: Colors.grey.shade200,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: 14, // Slightly smaller font for chips
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          
          // Added section title for clarity, styled to match bold text
          Text(
            'Recommended Courses',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          // Course list - Changed from ListView to GridView for 2 columns
          Expanded(
            child: filteredCourses.isEmpty
                ? const Center(child: Text('No courses found.'))
                : GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 items per row
                      crossAxisSpacing: 2.0, // Horizontal space between cards
                      mainAxisSpacing: 2.0, // Vertical space between cards
                      childAspectRatio: 1.0, // Maintains the square aspect ratio from CourseCard
                    ),
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) {
                      final course = filteredCourses[index];
                      final title = course['title'] as String;
                      return CourseCard(
                        title: title,
                        level: course['level'],
                        lessons: course['lessons'],
                        hours: course['hours'],
                        progress: course['progress'] ?? 0.0,
                        isBookmarked: bookmarkedCourses.contains(title),
                        image: course['image'] ,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CourseDetailsView()
                            ),
                          );
                        },
                        onBookmarkToggle: () => _toggleBookmark(title),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}