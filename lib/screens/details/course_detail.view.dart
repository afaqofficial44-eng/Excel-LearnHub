import 'package:excel_learn_hub/screens/components/gradiant_color.dart';
import 'package:excel_learn_hub/screens/components/primary_button.dart';
import 'package:excel_learn_hub/screens/details/course_detail.logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseDetailsView extends StatelessWidget {
  const CourseDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(CourseDetailsLogic());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
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
                      ),
                    ),
                    const SizedBox(height: 8),

                    /// 🔹 UPPER CONTAINER
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xFF6C6C6C),
                          width: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
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
                            child: const Center(
                              child: Image(
                                image: AssetImage('assets/images/flutter.png'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Flutter Mobile Development',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      'Build cross-platform apps with Flutter and Dart',
                                      style: TextStyle(
                                        color: Color(0xFF6C6C6C),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                height: 36,
                                width: 36,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 219, 199),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: ShaderMask(
                                  shaderCallback: (Rect bounds) {
                                    return xcelerateGradient.createShader(
                                      bounds,
                                    );
                                  },
                                  child: const Icon(
                                    Icons.bookmark_add_outlined,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          Row(
                            children: [
                              const Icon(
                                Icons.bar_chart,
                                size: 18,
                                color: Color(0xFF6C6C6C),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFF1C6),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Beginner',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.menu_book,
                                size: 18,
                                color: Color(0xFF6C6C6C),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                '12 lessons',
                                style: TextStyle(fontSize: 10),
                              ),
                              const SizedBox(width: 12),
                              const Icon(
                                Icons.access_time,
                                size: 18,
                                color: Color(0xFF6C6C6C),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                '8 hours',
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Your Progress',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                '16%',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Obx(
                            () => ClipRRect(
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
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    ///  LOWER CONTAINER
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color(0xFF6C6C6C),
                          width: 0.2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
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
                          const Text(
                            '2 of 12 lessons completed',
                            style: TextStyle(
                              color: Color(0xFF6C6C6C),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Module List
                          Obx(
                            () => Column(
                              children: logic.modules
                                  .map((m) => _buildModule(context, logic, m))
                                  .toList(),
                            ),
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
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModule(
    BuildContext context,
    CourseDetailsLogic logic,
    Module module,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFF6C6C6C), width: 0.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
                      ?  CircleAvatar(
                          radius: 14,
                          backgroundColor: Color.fromARGB(255, 255, 219, 199),
                          child: ShaderMask(
  shaderCallback: (Rect bounds) {
    return xcelerateGradient.createShader(bounds);
  },
                            child: Icon(
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
                  onTap: () => logic.markLessonDone(module, lesson),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
