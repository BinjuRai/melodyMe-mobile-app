import 'package:batch34_b/features/course/domain/entity/course_entity.dart';

abstract class CourseState {}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {
  final List<CourseEntity> courses;
  final int currentPage;
  final bool hasMore;

  CourseLoaded(this.courses, this.currentPage, this.hasMore);
}

class CourseError extends CourseState {
  final String message;
  CourseError(this.message);
}
