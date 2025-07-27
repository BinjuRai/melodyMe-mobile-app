import 'package:equatable/equatable.dart';

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
  final String lessonId;
  final bool isInWishlist;

  const ToggleWishlistLesson({
    required this.userId,
    required this.lessonId,
    required this.isInWishlist,
  });

  @override
  List<Object?> get props => [userId, lessonId, isInWishlist];
}
