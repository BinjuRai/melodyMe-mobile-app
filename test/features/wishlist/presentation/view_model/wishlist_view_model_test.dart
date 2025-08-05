import 'package:batch34_b/features/wishlist/presentation/view_model/wishlist_event.dart';
import 'package:batch34_b/features/wishlist/presentation/view_model/wishlist_state.dart';
import 'package:batch34_b/features/wishlist/presentation/view_model/wishlist_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:batch34_b/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:batch34_b/core/error/failure.dart';

class MockWishlistRepository extends Mock implements WishlistRepository {}

void main() {
  late WishlistBloc wishlistBloc;
  late MockWishlistRepository mockRepository;

  const userId = 'user123';
  final lesson = LessonEntity(
    id: 'lesson1',
    name: 'Lesson 1',
    description: 'Test description',
    authorName: 'John',
    duration: '1h',
    price: 10,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  setUp(() {
    mockRepository = MockWishlistRepository();
    wishlistBloc = WishlistBloc(wishlistRepository: mockRepository);
  });

  tearDown(() => wishlistBloc.close());

  group('LoadWishlist', () {
    blocTest<WishlistBloc, WishlistState>(
      'emits [WishlistLoading, WishlistLoaded] on success',
      build: () {
        when(
          () => mockRepository.getWishlistLessons(userId),
        ).thenAnswer((_) async => Right([lesson]));
        return wishlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWishlist(userId: userId)),
      expect:
          () => [
            WishlistLoading(),
            WishlistLoaded([lesson]),
          ],
    );

    blocTest<WishlistBloc, WishlistState>(
      'emits [WishlistLoading, WishlistError] on failure',
      build: () {
        when(
          () => mockRepository.getWishlistLessons(userId),
        ).thenAnswer((_) async => Left(ServerFailure(message: 'Failed')));
        return wishlistBloc;
      },
      act: (bloc) => bloc.add(const LoadWishlist(userId: userId)),
      expect: () => [WishlistLoading(), isA<WishlistError>()],
    );
  });

  group('ToggleWishlistLesson', () {
    blocTest<WishlistBloc, WishlistState>(
      'removes lesson from wishlist',
      build: () {
        when(
          () => mockRepository.removeLessonFromWishlist(userId, lesson.id),
        ).thenAnswer((_) async => const Right(null));
        return wishlistBloc;
      },
      seed: () => WishlistLoaded([lesson]),
      act:
          (bloc) => bloc.add(
            ToggleWishlistLesson(
              userId: userId,
              lesson: lesson,
              isInWishlist: true,
            ),
          ),
      expect: () => [WishlistLoaded([])],
    );

    blocTest<WishlistBloc, WishlistState>(
      'adds lesson to wishlist',
      build: () {
        when(
          () => mockRepository.addLessonToWishlist(userId, lesson),
        ).thenAnswer((_) async => const Right(null));
        return wishlistBloc;
      },
      seed: () => WishlistLoaded([]),
      act:
          (bloc) => bloc.add(
            ToggleWishlistLesson(
              userId: userId,
              lesson: lesson,
              isInWishlist: false,
            ),
          ),
      expect:
          () => [
            WishlistLoaded([lesson]),
          ],
    );

    blocTest<WishlistBloc, WishlistState>(
      'emits WishlistError when add fails',
      build: () {
        when(
          () => mockRepository.addLessonToWishlist(userId, lesson),
        ).thenAnswer((_) async => Left(ServerFailure(message: 'Failed')));
        return wishlistBloc;
      },
      seed: () => WishlistLoaded([]),
      act:
          (bloc) => bloc.add(
            ToggleWishlistLesson(
              userId: userId,
              lesson: lesson,
              isInWishlist: false,
            ),
          ),
      expect: () => [isA<WishlistError>()],
    );
  });
}
