class Lesson {
  final String title;
  final String duration;
  bool done;

  Lesson({required this.title, required this.duration, this.done = false});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      title: json['title'] as String,
      duration: json['duration'] as String,
      done: json['done'] as bool? ?? false, // Handle null/missing 'done' gracefully
    );
  }
}

// 2. Updated Module model with a factory constructor
class Module {
  final String title;
  final String subtitle;
  final List<Lesson> lessons;

  Module({required this.title, required this.subtitle, required this.lessons});

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      lessons: (json['lessons'] as List<dynamic>?)
              ?.map((l) => Lesson.fromJson(l as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

// 3. NEW CourseDetail model (for the detail screen)
class CourseDetail {
  final int id;
  final String title;
  final List<Module> modules;
  // We'll add temporary hardcoded values for progress, lessons, and duration here
  // as the API doesn't provide them directly in this format.

  CourseDetail({
    required this.id,
    required this.title,
    required this.modules,
  });

  factory CourseDetail.fromJson(Map<String, dynamic> json) {
    return CourseDetail(
      id: json['id'] as int,
      title: json['title'] as String,
      modules: (json['modules'] as List<dynamic>?)
              ?.map((m) => Module.fromJson(m as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}