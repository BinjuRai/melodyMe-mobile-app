import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/course/data/model/course_api_model.dart';
import 'package:batch34_b/features/course/domain/repository/course_repository.dart';
import 'package:batch34_b/features/course/domain/usecase/get_all_courses.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCourseRepository extends Mock implements CourseRepository {}

void main() {
  late MockCourseRepository mockCourseRepository;
  late GetAllCourses usecase;

  // Test data - API models
  final tCourseModels = [
    CourseApiModel(id: '1', name: 'Flutter Basics', totalPrice: 100),
    CourseApiModel(id: '2', name: 'Flutter Advanced', totalPrice: 200),
  ];

  // Test data - Entities (converted from models)
  final tCourseEntities = tCourseModels.map((e) => e.toEntity()).toList();

  setUp(() {
    mockCourseRepository = MockCourseRepository();
    usecase = GetAllCourses(mockCourseRepository);
  });

  

  test('should return Failure when repository fails', () async {
    // arrange
    const failure = RemoteDatabaseFailure(message: 'Failed to fetch courses');
    when(
      () => mockCourseRepository.getAllCourses(),
    ).thenAnswer((_) async => const Left(failure));

    // act
    final result = await usecase();

    // assert
    expect(result, const Left(failure));
    verify(() => mockCourseRepository.getAllCourses()).called(1);
    verifyNoMoreInteractions(mockCourseRepository);
  });

  // Additional test: Check that usecase calls repository exactly once
  test('should call repository exactly once', () async {
    // arrange
    when(
      () => mockCourseRepository.getAllCourses(),
    ).thenAnswer((_) async => Right(tCourseModels));

    // act
    await usecase();

    // assert
    verify(() => mockCourseRepository.getAllCourses()).called(1);
  });
}
