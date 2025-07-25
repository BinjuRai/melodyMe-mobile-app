import 'package:batch34_b/features/course/domain/entity/course_entity.dart';
import 'package:batch34_b/features/course/domain/repository/course_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:batch34_b/core/error/failure.dart';

class GetAllCourses {
  final CourseRepository repository;

  GetAllCourses(this.repository);

  Future<Either<Failure, List<CourseEntity>>> call() async {
    final result = await repository.getAllCourses();

    return result.fold(
      (failure) => Left(failure), // propagate failure
      (courseModels) {
        // Convert CourseApiModel to CourseEntity
        final courseEntities = courseModels.map((model) => model.toEntity()).toList();
        return Right(courseEntities);
      },
    );
  }
}
