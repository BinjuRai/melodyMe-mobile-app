import 'dart:io';

abstract class CourseEvent {}

class FetchCourses extends CourseEvent {
  final int page;
  FetchCourses({this.page = 1});
}

class CreateCourse extends CourseEvent {
  final String name;
  final File? image;
  CreateCourse(this.name, this.image);
}
