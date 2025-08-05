import 'package:equatable/equatable.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object?> get props => [];
}

class WishlistLoading extends WishlistState {}

class WishlistLoaded extends WishlistState {
  final List<LessonEntity> lessons;

  const WishlistLoaded(this.lessons);

  @override
  List<Object?> get props => [lessons];
}

class WishlistError extends WishlistState {
  final String message;

  const WishlistError(this.message);

  @override
  List<Object?> get props => [message];
}
