import 'package:batch34_b/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:batch34_b/core/error/failure.dart';

class AddToWishlist {
  final WishlistRepository repository;

  AddToWishlist(this.repository);

  Future<Either<Failure, void>> call(String userId, LessonEntity lesson) {
    return repository.addLessonToWishlist(userId, lesson);
  }
}
