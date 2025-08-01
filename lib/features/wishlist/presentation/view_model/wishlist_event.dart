import 'package:equatable/equatable.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';

abstract class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object?> get props => [];
}

class LoadWishlist extends WishlistEvent {
  final String userId;

  const LoadWishlist({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class ToggleWishlistLesson extends WishlistEvent {
  final String userId;
  final LessonEntity lesson; 
  final bool isInWishlist;

  const ToggleWishlistLesson({
    required this.userId,
    required this.lesson,
    required this.isInWishlist,
  });

  @override
  List<Object?> get props => [userId, lesson, isInWishlist];
}
