import 'package:batch34_b/features/course/presentation/view_model/course_detail_bloc.dart';
import 'package:batch34_b/features/course/presentation/view_model/course_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';

class UserViewCourseDetailScreen extends StatelessWidget {
  final String courseId;

  const UserViewCourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    // Trigger loading the course & lessons on screen load
    context.read<CourseDetailBloc>().loadCourseDetail(courseId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Detail'),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocBuilder<CourseDetailBloc, CourseDetailState>(
        builder: (context, state) {
          if (state is CourseDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CourseDetailLoaded) {
            final course = state.course;
            final List<LessonEntity> lessons = state.lessons;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Price: \$${course.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Lessons:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child:
                        lessons.isEmpty
                            ? const Center(child: Text("No lessons available."))
                            : ListView.builder(
                              itemCount: lessons.length,
                              itemBuilder: (context, index) {
                                final lesson = lessons[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  child: ListTile(
                                    leading: const Icon(Icons.play_circle_fill),
                                    title: Text(lesson.name),
                                    subtitle: Text(
                                      'Duration: ${lesson.duration ?? 'N/A'}',
                                    ),
                                    onTap: () {
                                      // TODO: handle lesson click
                                    },
                                  ),
                                );
                              },
                            ),
                  ),
                ],
              ),
            );
          } else if (state is CourseDetailError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(child: Text('Unexpected state.'));
          }
        },
      ),
    );
  }
}
