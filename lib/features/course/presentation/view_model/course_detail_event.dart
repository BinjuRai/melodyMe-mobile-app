abstract class CourseDetailEvent {}

class FetchCourseDetail extends CourseDetailEvent {
  final String courseId;
  FetchCourseDetail(this.courseId);
}
