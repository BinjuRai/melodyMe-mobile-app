
import 'package:dartz/dartz.dart';
import 'package:batch34_b/core/error/failure.dart';

// Use prefixes for both to avoid ambiguity
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart' as lesson_entity;
import 'package:batch34_b/features/lesson/domain/entity/lesson_response.dart' as lesson_response;

abstract class LessonRepository {
  Future<Either<Failure, lesson_response.LessonResponse>> getAllLessons({
    int page = 1,
    int limit = 10,
    String? search,
  });

  Future<Either<Failure, lesson_entity.LessonEntity>> getLessonById(String id);
}



// abstract class LessonRepository {
//   Future<Either<Failure, LessonResponse>> getAllLessons({
//     int page = 1,
//     int limit = 10,
//     String? search,
//   });
  
//   Future<Either<Failure, LessonEntity>> getLessonById(String id);
// }