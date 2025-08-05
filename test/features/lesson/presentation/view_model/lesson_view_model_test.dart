import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:batch34_b/features/lesson/domain/usecase/get_all_lesson_usecase.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_response.dart';

import 'package:batch34_b/features/lesson/presentation/view_model/lesson_event.dart';
import 'package:batch34_b/features/lesson/presentation/view_model/lesson_state.dart';
import 'package:batch34_b/features/lesson/presentation/view_model/lesson_view_model.dart';
import 'package:batch34_b/features/lesson/domain/repository/lesson_repository.dart';

class MockLessonRepository extends Mock implements LessonRepository {}

class MockGetAllLessonsUseCase extends Mock implements GetAllLessonsUseCase {}

void main() {
  late LessonBloc bloc;
  late MockLessonRepository repo;
  late MockGetAllLessonsUseCase useCase;

  setUp(() {
    repo = MockLessonRepository();
    useCase = MockGetAllLessonsUseCase();
    bloc = LessonBloc(getAllLessonsUseCase: useCase, lessonRepository: repo);
  });

  final lessonList = [LessonEntity.empty()];
  final pagination = LessonPagination.empty();
  final response = LessonResponse(lessons: lessonList, pagination: pagination);

  blocTest<LessonBloc, LessonState>(
    'emits [LessonLoadingState, LessonLoadedState] when LoadLessonsEvent is successful',
    build: () {
      when(
        () => useCase.call(page: 1, limit: 1000, search: null),
      ).thenAnswer((_) async => Right(response));
      return bloc;
    },
    act: (bloc) => bloc.add(const LoadLessonsEvent()),
    expect:
        () => [
          const LessonLoadingState(),
          LessonLoadedState(
            lessons: lessonList,
            pagination: pagination,
            hasReachedMax: true,
            searchQuery: null,
          ),
        ],
  );
}

  // blocTest<LessonBloc, LessonState>(
  //   'emits [LessonLoadingState, LessonErrorState] when LoadLessonsEvent fails',
  //   build: () {
  //     when(() => useCase.call(page: 1, limit: 1000, search: null))
  //         .thenAnswer((_) async => Left(ServerFailure("Error", message: '')));
  //     return bloc;
  //   },
  //   act: (bloc) => bloc.add(const LoadLessonsEvent()),
  //   expect: () => [
  //     const LessonLoadingState(),
  //     const LessonErrorState(message: "Error"),
  //   ],
  // );
// blocTest<LessonBloc, LessonState>(
//   'emits [LessonLoadingState, LessonErrorState] when LoadLessonsEvent fails',
//   build: () {
//    when(() => useCase.call(page: 1, limit: 1000, search: null))
//   .thenAnswer((_) async => Left(ServerFailure("Error")));
//     return bloc;
//   },
//   act: (bloc) => bloc.add(const LoadLessonsEvent()),
//   expect: () => [
//     const LessonLoadingState(),
//     const LessonErrorState(message: "Error"),
//   ],
// );
// }
// Remove the duplicate Failure and ServerFailure definitions
