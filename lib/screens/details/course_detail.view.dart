import 'package:excel_learn_hub/screens/components/gradiant_color.dart';
import 'package:excel_learn_hub/screens/components/primary_button.dart';
import 'package:excel_learn_hub/screens/details/course_detail.logic.dart';
import 'package:excel_learn_hub/screens/details/detail_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseDetailsView extends StatelessWidget {
  // Use a final logic variable to access the controller throughout the build method
  final CourseDetailsLogic logic;

  // The logic is initialized externally when navigating, so accept it here.
  const CourseDetailsView({required this.logic, super.key});

  @override
  Widget build(BuildContext context) {
    // We already have the logic instance, no need for Get.put here
    // final logic = Get.put(CourseDetailsLogic());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          // 🔹 HANDLE LOADING & ERROR STATES
          if (logic.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (logic.errorMessage.isNotEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Error: ${logic.errorMessage.value}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          // Get the data
          final course = logic.courseDetail.value;
          if (course == null) {
            return const Center(child: Text('Course data not available.'));
          }

          // 🔹 MAIN CONTENT
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(Icons.arrow_back),
                          padding: EdgeInsets.zero,
                          color: Colors.black87,
                          visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
                        ),
                      ),
                      const SizedBox(height: 8),

                      /// 🔹 UPPER CONTAINER
                      Container(
                        // ... (Your existing styling for the upper container)
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFF6C6C6C),
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF2F6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                // Placeholder image
                                child: ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return xcelerateGradient.createShader(
                                      bounds,
                                    );
                                  },
                                  child: const Icon(
                                    Icons.play_circle_filled,
                                    size: 60,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // 💡 Use fetched title
                                      Text(
                                        course.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      const Text(
                                        // Placeholder subtitle since API doesn't provide a summary
                                        'Excel in Your Skills. Unlock Your Potential. 💡',
                                        style: TextStyle(
                                          color: Color(0xFF6C6C6C),
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // (Bookmark Icon is unchanged)
                              ],
                            ),
                            const SizedBox(height: 12),

                            Row(
                              children: [
                                // (Difficulty icon is hardcoded, keep as is)
                                const Icon(
                                  Icons.bar_chart,
                                  size: 18,
                                  color: Color(0xFF6C6C6C),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'Beginner',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Icon(
                                  Icons.menu_book,
                                  size: 18,
                                  color: Color(0xFF6C6C6C),
                                ),
                                const SizedBox(width: 6),
                                // 💡 Use calculated total lessons
                                Text(
                                  '${logic.totalLessons} lessons',
                                  style: const TextStyle(fontSize: 10),
                                ),
                                const SizedBox(width: 12),
                                const Icon(
                                  Icons.access_time,
                                  size: 18,
                                  color: Color(0xFF6C6C6C),
                                ),
                                const SizedBox(width: 6),
                                // 💡 Use calculated total duration
                                Text(
                                  logic.totalDuration,
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ],
                            ),

                            const SizedBox(height: 12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Your Progress',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 13,
                                  ),
                                ),
                                // 💡 Use calculated progress percentage
                                Text(
                                  logic.progressPercent,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            // 💡 Use calculated progress value
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return xcelerateGradient.createShader(bounds);
                                },
                                child: LinearProgressIndicator(
                                  value: logic.progress.value,
                                  minHeight: 8,
                                  backgroundColor: Colors.transparent,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      ///  LOWER CONTAINER
                      Container(
                        // ... (Your existing styling for the lower container)
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFF6C6C6C),
                            width: 0.2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Course Content',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 6),
                            // 💡 Use calculated completed/total lessons
                            Text(
                              '${logic.completedLessons} of ${logic.totalLessons} lessons completed',
                              style: const TextStyle(
                                color: Color(0xFF6C6C6C),
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Module List
                            Column(
                              children: logic.modules
                                  .map((m) => _buildModule(context, logic, m))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),

              /// 🔹 FIXED BOTTOM BUTTON
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: SizedBox(
                  height: 56,
                  child: PrimaryButton(
                    text: "Continue Learning",
                    onPressed: logic.continueLearning,
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // (Keep the _buildModule function as is, it now uses the data from the updated logic)
  Widget _buildModule(
    BuildContext context,
    CourseDetailsLogic logic,
    Module module,
  ) {
    // ... (your existing _buildModule implementation)
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF6C6C6C), width: 0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
        backgroundColor: Colors.white,
        collapsedBackgroundColor: Colors.white,
        title: Text(
          '${module.title} • ${module.subtitle}',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        children: module.lessons
            .map(
              (lesson) => Container(
                color: Colors.white,
                child: ListTile(
                  horizontalTitleGap: 10,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 0,
                  ),
                  leading: lesson.done
                      ? CircleAvatar(
                          radius: 14,
                          backgroundColor: const Color.fromARGB(
                            255,
                            255,
                            219,
                            199,
                          ),
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return xcelerateGradient.createShader(bounds);
                            },
                            child: const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : const CircleAvatar(
                          radius: 14,
                          backgroundColor: Color(0xFFF0F3F6),
                          child: Icon(
                            Icons.play_arrow,
                            size: 16,
                            color: Colors.black87,
                          ),
                        ),
                  title: Text(
                    lesson.title,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: lesson.done
                          ? FontWeight.w500
                          : FontWeight.w600,
                      color: lesson.done ? Colors.black54 : Colors.black87,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        lesson.duration,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(width: 6),
                      if (!lesson.done)
                        const Icon(
                          Icons.chevron_right,
                          color: Colors.black26,
                          size: 18,
                        ),
                    ],
                  ),
                  // The onTap calls the logic's method, which recalculates progress and refreshes
                  onTap: () => logic.markLessonDone(module, lesson),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
