import 'package:batch34_b/features/course/domain/entity/course_entity.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';

abstract class CourseDetailState {}

class CourseDetailInitial extends CourseDetailState {}

class CourseDetailLoading extends CourseDetailState {}

class CourseDetailLoaded extends CourseDetailState {
  final CourseEntity course;
  final List<LessonEntity> lessons;

  CourseDetailLoaded(this.course, this.lessons);
}

class CourseDetailError extends CourseDetailState {
  final String message;
  CourseDetailError(this.message);
}
