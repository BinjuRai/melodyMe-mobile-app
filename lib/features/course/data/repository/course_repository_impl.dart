import 'dart:io';

import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/course/data/data_source/remote_datasource/course_remote_datasource.dart';
import 'package:batch34_b/features/course/data/model/course_api_model.dart';
import 'package:batch34_b/features/course/domain/repository/course_repository.dart';
import 'package:dartz/dartz.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource remoteDataSource;

  CourseRepositoryImpl({required this.remoteDataSource});

  @override
Future<Either<Failure, List<CourseApiModel>>> getAllCourses() async {
  try {
    final models = await remoteDataSource.getAllCourses();  // no page param now
    return Right(models);
  } catch (e) {
    return Left(ServerFailure(message: e.toString()));
  }
}

  @override
  Future<Either<Failure, CourseApiModel>> createCourse(
    String name,
    File? image,
  ) async {
    try {
      final result = await remoteDataSource.createCourse(name, image);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCourse(String id) async {
    try {
      await remoteDataSource.deleteCourse(id);
      return const Right(unit); // Use dartz's Unit to indicate success
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CourseApiModel>> getCourseById(String id) async {
    try {
      final result = await remoteDataSource.getCourseById(id);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CourseApiModel>> updateCourse(
    String id,
    String name, {
    File? image,
  }) async {
    try {
      final result = await remoteDataSource.updateCourse(
        id,
        name,
        image: image,
      );
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
