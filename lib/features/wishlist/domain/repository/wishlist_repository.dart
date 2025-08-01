import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';

import 'package:dartz/dartz.dart';
import 'package:batch34_b/core/error/failure.dart';

abstract class WishlistRepository {
  Future<Either<Failure, List<LessonEntity>>> getWishlistLessons(String userId);

  // Future<Either<Failure, void>> addLessonToWishlist(String userId, LessonEntity lessons);
  Future<Either<Failure, void>> addLessonToWishlist(
    String userId,
    LessonEntity lesson,
  );

  Future<Either<Failure, void>> removeLessonFromWishlist(
    String userId,
    String lessonId,
  );

  Future<Either<Failure, LessonEntity>> getLessonById(String lessonId);
}
