import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:batch34_b/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'wishlist_event.dart';
import 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepository wishlistRepository;

  WishlistBloc({required this.wishlistRepository}) : super(WishlistLoading()) {
    on<LoadWishlist>(_onLoadWishlist);
    on<ToggleWishlistLesson>(_onToggleWishlistLesson);
  }

  // Future<void> _onLoadWishlist(
  //   LoadWishlist event,
  //   Emitter<WishlistState> emit,
  // ) async {
  //   emit(WishlistLoading());
  //   final result = await wishlistRepository.getWishlistLessons(event.userId);

  //   result.fold(
  //     (failure) => emit(WishlistError("Failed to load wishlist")),
  //     (lessons) => emit(WishlistLoaded(lessons)),
  //   );
  // }
  Future<void> _onLoadWishlist(
    LoadWishlist event,
    Emitter<WishlistState> emit,
  ) async {
    print('WishlistBloc: Loading wishlist for userId=${event.userId}');
    emit(WishlistLoading());

    final result = await wishlistRepository.getWishlistLessons(event.userId);

    result.fold(
      (failure) {
        print('WishlistBloc: Failed to load wishlist with failure: $failure');
        emit(WishlistError("Failed to load wishlist"));
      },
      (lessons) {
        print('WishlistBloc: Loaded ${lessons.length} lessons');
        emit(WishlistLoaded(lessons));
      },
    );
  }

  Future<void> _onToggleWishlistLesson(
    ToggleWishlistLesson event,
    Emitter<WishlistState> emit,
  ) async {
    if (state is WishlistLoaded) {
      final currentLessons = List<LessonEntity>.from(
        (state as WishlistLoaded).lessons,
      );

      if (event.isInWishlist) {
        // Remove lesson from wishlist
        final result = await wishlistRepository.removeLessonFromWishlist(
          event.userId,
          event.lessonId,
        );
        result.fold(
          (failure) =>
              emit(WishlistError("Failed to remove lesson from wishlist")),
          (_) {
            currentLessons.removeWhere((lesson) => lesson.id == event.lessonId);
            emit(WishlistLoaded(currentLessons));
          },
        );
      } else {
        // Add lesson to wishlist
        final lessonResult = await wishlistRepository.getLessonById(
          event.lessonId,
        );
        lessonResult.fold(
          (failure) => emit(WishlistError("Failed to get lesson details")),
          (lesson) async {
            final addResult = await wishlistRepository.addLessonToWishlist(
              event.userId,
              lesson,
            );
            addResult.fold(
              (failure) =>
                  emit(WishlistError("Failed to add lesson to wishlist")),
              (_) {
                currentLessons.add(lesson);
                emit(WishlistLoaded(currentLessons));
              },
            );
          },
        );
      }
    }
  }
}
