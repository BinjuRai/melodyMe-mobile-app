// // test/usecases/get_all_lessons_usecase_test.dart

// import 'package:flutter_test/flutter_test.dart';

// import 'package:dartz/dartz.dart';
// import 'package:batch34_b/core/error/failure.dart';
// import 'package:batch34_b/features/lesson/domain/usecase/get_all_lesson_usecase.dart';
// import 'package:batch34_b/features/lesson/domain/entity/lesson_response.dart';
// import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
// import 'package:batch34_b/features/lesson/domain/repository/lesson_repository.dart';
// import 'package:mocktail/mocktail.dart';

// // Mock class
// class MockLessonRepository extends Mock implements LessonRepository {}

// void main() {
//   late GetAllLessonsUseCase useCase;
//   late MockLessonRepository repository;

//   setUp(() {
//     repository = MockLessonRepository();
//     useCase = GetAllLessonsUseCase(repository);
//   });

//   final lessonList = [LessonEntity.empty()];
//   final pagination = LessonPagination.empty();
//   final response = LessonResponse(lessons: lessonList, pagination: pagination);

//   test('should return lesson response from repository', () async {
//     when(repository.getAllLessons(page: 1, limit: 10, search: null))
//         .thenAnswer((_) async => Right(response));

//     final result = await useCase(page: 1, limit: 10);

//     expect(result, Right(response));
//     verify(repository.getAllLessons(page: 1, limit: 10, search: null));
//     verifyNoMoreInteractions(repository);
//   });

//   test('should return failure when repository fails', () async {
//     when(repository.getAllLessons(page: 1, limit: 10, search: null))
//         .thenAnswer((_) async => Left(ServerFailure("Error")));

//     final result = await useCase(page: 1, limit: 10);

//     expect(result, Left(ServerFailure("Error")));
//   });
// }
