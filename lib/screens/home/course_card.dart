import 'package:excel_learn_hub/screens/components/gradiant_color.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String level;
  final int lessons; // Kept for potential detail view, but not displayed in compact card
  final int hours; // Kept for potential detail view, but not displayed in compact card
  final double progress;
  final bool isBookmarked;
  final VoidCallback onTap;
  final VoidCallback onBookmarkToggle;
  final String image;

  const CourseCard({
    super.key,
    required this.title,
    required this.level,
    required this.lessons,
    required this.hours,
    this.progress = 0,
    this.isBookmarked = false,
    required this.onTap,
    required this.onBookmarkToggle, required this.image,
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

  @override
  Widget build(BuildContext context) {
    // We remove the margin here as the parent GridView/Wrap will handle spacing
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        // Use AspectRatio to force the card into a square shape
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
                        // Slightly lighter fill for the level chip background
                        color: getLevelColor().withAlpha((0.2 * 255).toInt()), 
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        level,
                        style: TextStyle(
                          color: getLevelColor(),
                          fontWeight: FontWeight.w600,
                          fontSize: 10, // Small text size for compact card
                        ),
                      ),
                    ),
                    // Bookmark Button, using purple accent color
                    GestureDetector(
                      onTap: onBookmarkToggle,
                      child: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: isBookmarked ? Color(0xFFFF5200) : Colors.grey.shade400,
                        size: 20,
                      ),
                    ),
                  ],
                ),

                // 2. Center: Picture Placeholder Icon
                Expanded(
                  child: Center(
                    // Using a book icon as a central placeholder for the course image
                    child: Image.asset(image, width: 48, height: 48)
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
                        fontSize: 10, // Smaller font size for compact card
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
                        // Using purple accent color for progress
                        color: Colors.white, 
                        minHeight: 5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    
                    // Progress Percentage
                    Text(
                      '${(progress * 100).toStringAsFixed(0)}% Completed',
                      style: TextStyle(
                        fontSize: 10, // Smallest font size for detail text
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
