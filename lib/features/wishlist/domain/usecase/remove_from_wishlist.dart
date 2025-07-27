

import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:dartz/dartz.dart';
class RemoveFromWishlist {
  final WishlistRepository repository;

  RemoveFromWishlist(this.repository);

  Future<Either<Failure, void>> call(String userId, String lessonId) {
    return repository.removeLessonFromWishlist(userId, lessonId);
  }
}
