import 'dart:convert';
import 'package:excel_learn_hub/screens/details/detail_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CourseDetailsLogic extends GetxController {
  // Pass the courseId when creating the controller
  final int courseId;
  CourseDetailsLogic({required this.courseId});

  // State variables
  var courseDetail = Rxn<CourseDetail>(); // Rxn for a nullable observable
  var modules = <Module>[].obs;
  var progress = 0.0.obs; // Will be calculated
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Use the passed ID to fetch the data
    loadCourseData(courseId); 
  }

  // New API fetch logic
  Future<void> loadCourseData(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // The API returns a list of courses. We'll fetch the whole list and find the matching ID.
      // In a real app, you'd ideally have an API for a single course: e.g., /courses/$id
      final url = 'https://dummyjson.com/c/8e7c-9534-46f8-ad9e';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> coursesJson = json.decode(response.body);
        
        // Find the course matching the ID
        final courseJson = coursesJson.firstWhereOrNull(
          (c) => c['id'] == id,
        );

        if (courseJson != null) {
          final fetchedCourse = CourseDetail.fromJson(courseJson);
          courseDetail.value = fetchedCourse;
          modules.assignAll(fetchedCourse.modules);
          calculateProgress();
        } else {
          errorMessage.value = 'Course with ID $id not found.';
        }
      } else {
        errorMessage.value = 'Failed to load course details. Status: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading.value = false;
    }
  }

  // New method to calculate total progress
  void calculateProgress() {
    int totalLessons = 0;
    int completedLessons = 0;

    for (var module in modules) {
      totalLessons += module.lessons.length;
      completedLessons += module.lessons.where((l) => l.done).length;
    }

    if (totalLessons > 0) {
      progress.value = completedLessons / totalLessons;
    } else {
      progress.value = 0.0;
    }
    
    // Refresh the view to update calculated values
    courseDetail.refresh(); 
  }

  // Update logic to mark lesson done and recalculate progress
  void markLessonDone(Module module, Lesson lesson) {
    lesson.done = !lesson.done;
    modules.refresh();
    calculateProgress(); // Recalculate progress on change
  }

  void continueLearning() {
    Get.snackbar("Continue", "Resuming course: ${courseDetail.value?.title ?? '...'}");
  }
  
  // Helper to count total lessons
  int get totalLessons => modules.fold(0, (sum, m) => sum + m.lessons.length);
  
  // Helper to count completed lessons
  int get completedLessons => modules.fold(0, (sum, m) => sum + m.lessons.where((l) => l.done).length);
  
  // Helper to format progress percentage
  String get progressPercent => '${(progress.value * 100).toInt()}%';

  // Helper to calculate total duration (optional, assumes duration format is "X min")
  String get totalDuration {
    final totalMinutes = modules.fold<int>(0, (modSum, m) {
      return modSum + m.lessons.fold<int>(0, (lessonSum, l) {
        try {
          // Extracts the number and converts to int, defaults to 0 if format is wrong
          return lessonSum + (int.tryParse(l.duration.split(' ')[0]) ?? 0); 
        } catch (e) {
          return lessonSum;
        }
      });
    });

    if (totalMinutes < 60) return '$totalMinutes min';

    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    
    if (minutes == 0) return '$hours hrs';
    return '$hours hrs $minutes min';
  }
}