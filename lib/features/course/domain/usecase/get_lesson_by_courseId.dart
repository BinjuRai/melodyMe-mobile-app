import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/course/domain/repository/course_repository.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:dartz/dartz.dart';

// class GetLessonsByCourseUseCase {
//   final CourseRepository repository;

//   GetLessonsByCourseUseCase(this.repository);

//   Future<Either<Failure, List<LessonEntity>>> call(String courseId) {
//     final result = await repository.getLessonById(id);
//     return repository.getLessonsByCourse(courseId);
//   }
// }
class GetLessonsByCourseUseCase {
  final CourseRepository repository;

  GetLessonsByCourseUseCase(this.repository);

  Future<Either<Failure, List<LessonEntity>>> call(String courseId) async {
    return await repository.getLessonsByCourse(courseId);
  }
}
