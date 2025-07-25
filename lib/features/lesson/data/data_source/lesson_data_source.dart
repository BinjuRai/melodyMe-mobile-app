import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/lesson/data/model/lesson_api_model.dart';
import 'package:batch34_b/features/lesson/data/model/lesson_response_api_model.dart';
import 'package:batch34_b/features/lesson/data/model/pagination_api_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class LessonRemoteDataSource {
  Future<Either<Failure, LessonResponseModel?>> getAllLessons({
    int page = 1,
    int limit = 10,
    String? search,
  });

  Future<Either<Failure, LessonModel?>> getLessonById(String id);
}

class LessonRemoteDataSourceImpl implements LessonRemoteDataSource {
  final Dio dio;

  LessonRemoteDataSourceImpl({required this.dio});

  @override
  Future<Either<Failure, LessonResponseModel?>> getAllLessons({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    try {
      final queryParams = <String, dynamic>{'page': page, 'limit': limit};

      if (search != null && search.isNotEmpty) {
        queryParams['search'] = search;
      }

      final response = await dio.get(
        '/admin/lesson',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Check if the response has the expected structure
        if (data['success'] == true && data['data'] != null) {
          final lessons =
              (data['data'] as List)
                  .map((lessonJson) => LessonModel.fromJson(lessonJson))
                  .toList();

          // Create pagination from the actual data
          final totalItems = lessons.length;
          final totalPages = (totalItems / limit).ceil();

          final pagination = LessonPaginationModel(
            currentPage: page,
            totalPages: totalPages,
            totalItems: totalItems,
            itemsPerPage: limit,
            hasNext: page < totalPages,
            hasPrev: page > 1,
          );

          final lessonResponse = LessonResponseModel(
            lessons: lessons,
            pagination: pagination,
          );

          return Right(lessonResponse);
        } else {
          return Left(
            ServerFailure(message: data['message'] ?? 'Unknown error'),
          );
        }
      } else {
        return Left(
          ServerFailure(message: 'Server error: ${response.statusCode}'),
        );
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, LessonModel?>> getLessonById(String id) async {
    try {
      final response = await dio.get('/admin/lesson/$id');

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['success'] == true && data['data'] != null) {
          final lesson = LessonModel.fromJson(data['data']);
          return Right(lesson);
        } else {
          return Left(
            ServerFailure(message: data['message'] ?? 'Lesson not found'),
          );
        }
      } else {
        return Left(
          ServerFailure(message: 'Server error: ${response.statusCode}'),
        );
      }
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: 'Unexpected error: $e'));
    }
  }

  Failure _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(message: 'Connection timeout');
      case DioExceptionType.connectionError:
        return const NetworkFailure(message: 'No internet connection');
      case DioExceptionType.badResponse:
        return ServerFailure(
          message: 'Server error: ${e.response?.statusCode}',
        );
      default:
        return ServerFailure(message: 'Network error: ${e.message}');
    }
  }
}

// Make sure you have these failure classes defined
class ServerFailure extends Failure {
  const ServerFailure({required String message}) : super(message: message);
}

class NetworkFailure extends Failure {
  const NetworkFailure({required String message}) : super(message: message);
}
