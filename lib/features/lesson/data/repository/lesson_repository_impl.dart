import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/lesson/data/data_source/lesson_data_source.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:batch34_b/features/lesson/domain/repository/lesson_repository.dart';
import 'package:dartz/dartz.dart';

// Use alias to avoid ambiguous import
import 'package:batch34_b/features/lesson/domain/entity/lesson_response.dart' as domain;

class LessonRepositoryImpl implements LessonRepository {
  final LessonRemoteDataSource remoteDataSource;

  LessonRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, domain.LessonResponse>> getAllLessons({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    final result = await remoteDataSource.getAllLessons(
      page: page,
      limit: limit,
      search: search,
    );

    return result.fold(
      (failure) => Left(failure),
      (apiModel) {
        if (apiModel == null) {
          return Right(domain.LessonResponse.empty());
        }
        return Right(apiModel.toEntity());
      },
    );
  }

  @override
  Future<Either<Failure, LessonEntity>> getLessonById(String id) async {
    final result = await remoteDataSource.getLessonById(id);

    return result.fold(
      (failure) => Left(failure),
      (apiModel) {
        if (apiModel == null) {
          return Right(LessonEntity.empty());
        }
        return Right(apiModel.toEntity());
      },
    );
  }
}