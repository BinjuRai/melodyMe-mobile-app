import 'package:flutter/material.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';

class PaidLessonView extends StatelessWidget {
  final LessonEntity lesson;

  const PaidLessonView({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.name.isNotEmpty ? lesson.name : 'Lesson Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            if (lesson.imagePath != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  lesson.imagePath!,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              )
            else
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: Text("No Image")),
              ),
            const SizedBox(height: 16),

            // Name
            Text(
              lesson.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),

            // Author
            Text(
              "By: ${lesson.authorName}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),

            // Course Name
            if (lesson.courseName != null)
              Text(
                "Course: ${lesson.courseName!}",
                style: Theme.of(context).textTheme.titleSmall,
              ),

            const SizedBox(height: 16),

            // Description
            Text(
              lesson.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 24),

            // File path (if needed to show download/view button)
            if (lesson.filePath != null)
              ElevatedButton.icon(
                onPressed: () {
                  // Handle file action
                  // For example, open PDF or download
                },
                icon: const Icon(Icons.download),
                label: const Text("Access Lesson File"),
              )
            else
              const Text(
                "No lesson file available.",
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
