// ----------------------------------------------------------------------
// 1. Updated Data Model for API
// ----------------------------------------------------------------------

/// Data model representing a Course from the API
class Course {
  final int id;
  final String title;
  final String level;
  final int lessons;
  final int hours;
  final String category;
  final double progress;
  bool isBookmarked;
  final String image;
  final int completedLessons;
  final int totalLessons;
  final String lastAccessed;

  Course({
    required this.id,
    required this.title,
    required this.level,
    required this.lessons,
    required this.hours,
    required this.category,
    required this.progress,
    required this.isBookmarked,
    required this.image,
    required this.completedLessons,
    required this.totalLessons,
    required this.lastAccessed,
  });

  // Factory method to parse JSON into a Course object
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int,
      title: json['title'] as String,
      level: json['level'] as String,
      lessons: json['lessons'] as int,
      hours: json['hours'] as int,
      category: json['category'] as String,
      // API returns progress as double, ensuring correct casting
      progress: (json['progress'] as num).toDouble(),
      isBookmarked: json['isBookmarked'] as bool,
      image: json['image'] as String,
      completedLessons: json['completedLessons'] as int,
      totalLessons: json['totalLessons'] as int,
      lastAccessed: json['lastAccessed'] as String,
    );
  }
}