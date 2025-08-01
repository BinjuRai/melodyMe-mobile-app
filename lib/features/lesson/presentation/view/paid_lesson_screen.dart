import 'package:batch34_b/features/lesson/presentation/view/paid_lesson_view.dart';
import 'package:batch34_b/features/lesson/presentation/view_model/lesson_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:batch34_b/features/lesson/presentation/view_model/lesson_state.dart';
import 'package:batch34_b/features/lesson/presentation/view_model/lesson_event.dart';

class PaidLessonScreen extends StatelessWidget {
  final String lessonId;

  const PaidLessonScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<LessonBloc>(context)
        ..add(LoadLessonByIdEvent(lessonId: lessonId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Lesson Detail')),
        body: BlocBuilder<LessonBloc, LessonState>(
          builder: (context, state) {
            if (state is LessonDetailLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LessonDetailLoadedState) {
              final lesson = state.lesson;
              return PaidLessonView(lesson: lesson); // From earlier step
            } else if (state is LessonDetailErrorState) {
              return Center(child: Text("Error: ${state.message}"));
            } else {
              return const Center(child: Text("Unknown state"));
            }
          },
        ),
      ),
    );
  }
}
