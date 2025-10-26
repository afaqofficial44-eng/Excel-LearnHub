import 'package:excel_learn_hub/screens/components/gradiant_color.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String level;
  final double progress;
  final bool isBookmarked;
  final VoidCallback onTap;
  final VoidCallback onBookmarkToggle;
  final String image; // Asset path is stored here

  const CourseCard({
    super.key,
    required this.title,
    required this.level,
    required this.progress,
    required this.isBookmarked,
    required this.onTap,
    required this.onBookmarkToggle,
    required this.image,
    required int lessons, // Kept for compatibility but unused
    required int hours, // Kept for compatibility but unused
  });

  Color getLevelColor() {
    switch (level.toLowerCase()) {
      case 'beginner':
        return Colors.green.shade600;
      case 'intermediate':
        return Colors.amber.shade700;
      case 'advanced':
        return Colors.red.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  // Helper to map image path to an icon for visual representation
  Widget _buildCourseIcon() {
    IconData icon;
    if (image.contains('flutter')) {
      icon = Icons.mobile_friendly; // Flutter - Mobile App
    } else if (image.contains('js')) {
      icon = Icons.javascript; // JavaScript - Web/Programming
    } else if (image.contains('py')) {
      icon = Icons.bar_chart; // Python / Data - Analytics
    } else if (image.contains('node')) {
      icon = Icons.dns; // Node.js - Backend/Server
    } else if (image.contains('jp') || image.contains('java')) {
      icon = Icons.coffee; // Java - Programming
    } else if (image.contains('kotlin')) {
      icon = Icons.developer_mode; // Kotlin - Android Dev
    } else if (image.contains('swift')) {
      icon = Icons.phone_iphone; // Swift - iOS Dev
    } else if (image.contains('cpp')) {
      icon = Icons.code; // C++ - Programming
    } else if (image.contains('datavis')) {
      icon = Icons.show_chart; // Data Visualization - Charts
    } else if (image.contains('django')) {
      icon = Icons.storage; // Django - Backend Web
    } else {
      icon = Icons.school; // Default fallback
    }

    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return xcelerateGradient.createShader(bounds);
      },
      child: Icon(icon, size: 48, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Top Row: Level Chip and Bookmark Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Level Chip
                    Container(
                      decoration: BoxDecoration(
                        color: getLevelColor().withAlpha((0.2 * 255).toInt()),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      child: Text(
                        level,
                        style: TextStyle(
                          color: getLevelColor(),
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    // Bookmark Button
                    GestureDetector(
                      onTap: onBookmarkToggle,
                      child: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: isBookmarked
                            ? const Color(0xFFFF5200)
                            : Colors.grey.shade400,
                        size: 20,
                      ),
                    ),
                  ],
                ),

                // 2. Center: Picture Placeholder Icon
                Expanded(
                  child: Center(
                    child: _buildCourseIcon(), // Use the helper widget
                  ),
                ),

                // 3. Bottom Section: Title and Progress
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Progress Bar
                    ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return xcelerateGradient.createShader(bounds);
                      },
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.transparent,
                        color: Colors.white,
                        minHeight: 5,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Progress Percentage
                    Text(
                      '${(progress * 100).toStringAsFixed(0)}% Completed',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
