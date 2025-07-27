import 'package:batch34_b/features/wishlist/domain/repository/wishlist_repository.dart';

import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:dartz/dartz.dart';

class GetWishlist {
  final WishlistRepository repository;

  GetWishlist(this.repository);

  Future<Either<Failure, List<LessonEntity>>> call(String userId) {
    return repository.getWishlistLessons(userId);
  }
}
