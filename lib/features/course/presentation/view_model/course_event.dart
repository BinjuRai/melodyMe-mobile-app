import 'dart:io';

abstract class CourseEvent {
  const CourseEvent();  // const constructor here
}

class FetchCourses extends CourseEvent {
  final int page;
  const FetchCourses({this.page = 1});  // const constructor
}

class CreateCourse extends CourseEvent {
  final String name;
  final File? image;
  CreateCourse(this.name, this.image);  // cannot be const because of File? image
}

class LoadCoursesEvent extends CourseEvent {
  const LoadCoursesEvent() : super();  // const constructor
}
