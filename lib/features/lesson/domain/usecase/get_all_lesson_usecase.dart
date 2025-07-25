

import 'package:dartz/dartz.dart';
import 'package:batch34_b/core/error/failure.dart';

// Prefix the imports to avoid name collision
import 'package:batch34_b/features/lesson/domain/entity/lesson_response.dart' as lesson_response;

import 'package:batch34_b/features/lesson/domain/repository/lesson_repository.dart';





class GetAllLessonsUseCase {
  final LessonRepository _repository;

  GetAllLessonsUseCase(this._repository);

  Future<Either<Failure, lesson_response.LessonResponse>> call({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    return await _repository.getAllLessons(
      page: page,
      limit: limit,
      search: search,
    );
  }
}