import 'dart:io';

import 'package:batch34_b/features/course/data/model/course_api_model.dart';
import 'package:batch34_b/features/lesson/data/model/lesson_api_model.dart';

abstract class CourseRemoteDataSource {
  Future<List<CourseApiModel>> getAllCourses();
  Future<CourseApiModel> getCourseById(String id);
  Future<void> deleteCourse(String id);
  Future<CourseApiModel> createCourse(String name, File? image);
  Future<CourseApiModel> updateCourse(String id, String name, {File? image});

  // Declare the method to fetch lessons by courseId here:
  // Future<List<LessonModel>> getLessonsByCourse(String courseId);
    Future<List<LessonModel>> getLessonsByCourse(String courseId);
}
