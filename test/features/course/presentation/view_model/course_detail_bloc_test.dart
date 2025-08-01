import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/course/data/model/course_api_model.dart';
import 'package:batch34_b/features/course/domain/entity/course_entity.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:batch34_b/features/course/domain/repository/course_repository.dart';
import 'package:batch34_b/features/course/domain/usecase/get_lesson_by_courseId.dart';
import 'package:batch34_b/features/course/presentation/view_model/course_detail_bloc.dart';
import 'package:batch34_b/features/course/presentation/view_model/course_detail_event.dart';
import 'package:batch34_b/features/course/presentation/view_model/course_detail_state.dart';

// Mock classes
class MockCourseRepository extends Mock implements CourseRepository {}

class MockGetLessonsByCourseUseCase extends Mock implements GetLessonsByCourseUseCase {}

void main() {
  late MockCourseRepository mockRepository;
  late MockGetLessonsByCourseUseCase mockGetLessons;
  late CourseDetailBloc bloc;

  const testCourseId = 'course-1';

  // Create a valid CourseApiModel instance (adjust fields as needed)
  final testCourseApiModel = CourseApiModel(
    id: testCourseId,
    name: 'Test Course',
    totalPrice: 111,
    // Add other required fields here with dummy/test values
  );

  final testLessons = <LessonEntity>[
    LessonEntity(
      id: 'lesson-1',
      name: '',
      description: '',
      authorName: '',
      duration: '',
      price: 11,
      createdAt: DateTime(2023, 1, 1),
      updatedAt: DateTime(2023, 1, 2),
    )
  ];

  setUp(() {
    mockRepository = MockCourseRepository();
    mockGetLessons = MockGetLessonsByCourseUseCase();
    bloc = CourseDetailBloc(
      courseRepository: mockRepository,
      getLessonsByCourseUseCase: mockGetLessons,
    );

    registerFallbackValue(FetchCourseDetail(testCourseId));
  });

  blocTest<CourseDetailBloc, CourseDetailState>(
    'emits [Loading, Loaded] when course and lessons are fetched successfully',
    build: () {
      when(() => mockRepository.getCourseById(testCourseId))
          .thenAnswer((_) async => Right(testCourseApiModel));
      when(() => mockRepository.getLessonsByCourse(testCourseId))
          .thenAnswer((_) async => Right(testLessons));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchCourseDetail(testCourseId)),
    expect: () => [
      isA<CourseDetailLoading>(),
      predicate<CourseDetailLoaded>((state) =>
          state.course.id == testCourseId && state.lessons.length == testLessons.length),
    ],
  );

  blocTest<CourseDetailBloc, CourseDetailState>(
    'emits [Loading, Error] when fetching course fails',
    build: () {
      when(() => mockRepository.getCourseById(testCourseId))
          .thenAnswer((_) async => Left(RemoteDatabaseFailure(message: 'Failed to fetch')));
      // lessons won't be fetched because course failed
      return bloc;
    },
    act: (bloc) => bloc.add(FetchCourseDetail(testCourseId)),
    expect: () => [
      isA<CourseDetailLoading>(),
      predicate<CourseDetailError>((state) =>
          state.message.contains('Failed to load course')),
    ],
  );

  blocTest<CourseDetailBloc, CourseDetailState>(
    'emits [Loading, Loaded with empty lessons] when lessons fetch fails',
    build: () {
      when(() => mockRepository.getCourseById(testCourseId))
          .thenAnswer((_) async => Right(testCourseApiModel));
      when(() => mockRepository.getLessonsByCourse(testCourseId))
          .thenAnswer((_) async => Left(RemoteDatabaseFailure(message: 'Lessons fetch failed')));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchCourseDetail(testCourseId)),
    expect: () => [
      isA<CourseDetailLoading>(),
      predicate<CourseDetailLoaded>((state) =>
          state.course.id == testCourseId && state.lessons.isEmpty),
    ],
  );

  blocTest<CourseDetailBloc, CourseDetailState>(
    'emits [Loading, Error] when courseId is empty',
    build: () => bloc,
    act: (bloc) => bloc.add(FetchCourseDetail('')),
    expect: () => [
      isA<CourseDetailLoading>(),
      predicate<CourseDetailError>((state) =>
          state.message.contains('cannot be empty')),
    ],
  );

  blocTest<CourseDetailBloc, CourseDetailState>(
    'emits [Loading, Error] when unexpected exception occurs',
    build: () {
      when(() => mockRepository.getCourseById(testCourseId))
          .thenThrow(Exception('Unexpected'));
      return bloc;
    },
    act: (bloc) => bloc.add(FetchCourseDetail(testCourseId)),
    expect: () => [
      isA<CourseDetailLoading>(),
      predicate<CourseDetailError>((state) =>
          state.message.contains('Unexpected error')),
    ],
  );
}
