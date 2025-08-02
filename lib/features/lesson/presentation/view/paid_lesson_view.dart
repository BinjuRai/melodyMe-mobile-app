import 'package:flutter/material.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';

class PaidLessonView extends StatelessWidget {
  final LessonEntity lesson;

  const PaidLessonView({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222740),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222740),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          lesson.name.isNotEmpty ? lesson.name : 'Lesson Details',
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            if (lesson.imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  lesson.imagePath!,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDE1F0),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    "No Image",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            const SizedBox(height: 20),

            // Lesson Name
            Text(
              lesson.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),

            // Author
            Text(
              "By: ${lesson.authorName}",
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFFF0C5CE),
              ),
            ),
            const SizedBox(height: 8),

            // Course Name
            if (lesson.courseName != null)
              Text(
                "Course: ${lesson.courseName!}",
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFFDDE1F0),
                ),
              ),

            const SizedBox(height: 20),

            // Description
            Text(
              lesson.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 32),

            // File Download Button or Notice
            if (lesson.filePath != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF0C5CE),
                    foregroundColor: const Color(0xFF222740),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  onPressed: () {
                    // TODO: Handle file action
                  },
                  icon: const Icon(Icons.download),
                  label: const Text(
                    "Access Lesson File",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            else
              const Text(
                "No lesson file available.",
                style: TextStyle(color: Colors.redAccent),
              ),
          ],
        ),
      ),
    );
  }
}
