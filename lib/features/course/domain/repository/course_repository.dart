import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/course/data/model/course_api_model.dart';

import 'package:dartz/dartz.dart';

import 'dart:io';

abstract class CourseRepository {
  Future<Either<Failure, List<CourseApiModel>>> getAllCourses();
  Future<Either<Failure, CourseApiModel>> getCourseById(String id);
  Future<Either<Failure, Unit>> deleteCourse(String id);
  Future<Either<Failure, CourseApiModel>> createCourse(String name, File? image);
  Future<Either<Failure, CourseApiModel>> updateCourse(String id, String name, {File? image});
}
