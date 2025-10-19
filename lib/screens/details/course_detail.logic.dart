import 'package:get/get.dart';

class Lesson {
  final String title;
  final String duration;
  bool done;

  Lesson({required this.title, required this.duration, this.done = false});
}

class Module {
  final String title;
  final String subtitle;
  final List<Lesson> lessons;

  Module({required this.title, required this.subtitle, required this.lessons});
}

class CourseDetailsLogic extends GetxController {
  // Sample data
  var modules = <Module>[].obs;
  var progress = 0.16.obs;

  @override
  void onInit() {
    super.onInit();
    loadCourseData();
  }

  void loadCourseData() {
    modules.assignAll([
      Module(
        title: 'Module 1',
        subtitle: 'Introduction & Setup',
        lessons: [
          Lesson(title: 'Welcome to the Course', duration: '5 min', done: true),
          Lesson(title: 'Setting up Your Environment', duration: '15 min', done: true),
          Lesson(title: 'Course Overview', duration: '8 min'),
        ],
      ),
      Module(
        title: 'Module 2',
        subtitle: 'Core Concepts',
        lessons: [
          Lesson(title: 'Widgets 101', duration: '12 min'),
          Lesson(title: 'State Management', duration: '17 min'),
        ],
      ),
      Module(
        title: 'Module 3',
        subtitle: 'Advanced Topics',
        lessons: [
          Lesson(title: 'Animations', duration: '22 min'),
          Lesson(title: 'Performance', duration: '18 min'),
        ],
      ),
      Module(
        title: 'Module 4',
        subtitle: 'Final Project',
        lessons: [
          Lesson(title: 'Project Overview', duration: '10 min'),
          Lesson(title: 'Submission', duration: '5 min'),
        ],
      ),
    ]);
  }

  void markLessonDone(Module module, Lesson lesson) {
    lesson.done = !lesson.done;
    modules.refresh();
  }

  void continueLearning() {
    Get.snackbar("Continue", "Resuming your course...");
  }
}
