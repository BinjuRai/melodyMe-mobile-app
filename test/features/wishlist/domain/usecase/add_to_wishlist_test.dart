import 'package:batch34_b/features/wishlist/domain/usecase/add_to_wishlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:batch34_b/features/wishlist/domain/repository/wishlist_repository.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:batch34_b/core/error/failure.dart';

// Create a mock class
class MockWishlistRepository extends Mock implements WishlistRepository {}

void main() {
  late AddToWishlist usecase;
  late MockWishlistRepository mockRepository;

  setUp(() {
    mockRepository = MockWishlistRepository();
    usecase = AddToWishlist(mockRepository);
  });

  const userId = 'user123';
  final lesson = LessonEntity(
  id: 'lesson1',
  name: 'Lesson 1',
  description: 'Test description',
  authorName: '',
  duration: '',
  price: 99,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);



  test('should call repository.addLessonToWishlist and return Right(void)', () async {
    // Arrange
    when(() => mockRepository.addLessonToWishlist(userId, lesson))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(userId, lesson);

    // Assert
    expect(result, const Right(null));
    verify(() => mockRepository.addLessonToWishlist(userId, lesson)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return Left(Failure) when repository fails', () async {
    // Arrange
final failure = ServerFailure(message: 'Unable to add to wishlist');
    when(() => mockRepository.addLessonToWishlist(userId, lesson))
        .thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase(userId, lesson);

    // Assert
    expect(result, Left(failure));
    verify(() => mockRepository.addLessonToWishlist(userId, lesson)).called(1);
  });
}
