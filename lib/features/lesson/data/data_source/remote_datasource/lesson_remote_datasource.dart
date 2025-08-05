// import 'package:batch34_b/features/lesson/data/model/lesson_api_model.dart';
// import 'package:batch34_b/features/lesson/data/model/lesson_response_api_model.dart';
// import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:batch34_b/core/error/failure.dart';

// abstract class LessonRemoteDataSource {
//   Future<Either<Failure, LessonResponseModel>> getAllLessons({
//     int page = 1,
//     int limit = 10,
//     String? search,
//   });

//   Future<Either<Failure, LessonModel>> getLessonById(String id);
// }

// class LessonRemoteDataSourceImpl implements LessonRemoteDataSource {
//   final Dio dio;

//   LessonRemoteDataSourceImpl({required this.dio});

//   @override
//   // Future<Either<Failure, LessonResponseModel>> getAllLessons({
//   //   int page = 1,
//   //   int limit = 10,
//   //   String? search,
//   // }) async {
//   //   try {
//   //     final response = await dio.get(
//   //       '/lessons',
//   //       queryParameters: {
//   //         'page': page,
//   //         'limit': limit,
//   //         if (search != null && search.isNotEmpty) 'search': search!,
//   //       },
//   //     );
//   //     final apiModel = LessonResponseModel.fromJson(response.data);
//   //     return Right(apiModel);
//   //   } on DioError catch (e) {
//   //     return Left(ServerFailure(message: e.message ?? 'Unknown error'));
//   //   }
//   // }
//   Future<Either<Failure, LessonResponseModel>> getAllLessons({
//     int page = 1,
//     int limit = 10,
//     String? search,
//   }) async {
//     try {
//       final response = await dio.get(
//         '/lessons',
//         queryParameters: {
//           'page': page,
//           'limit': limit,
//           if (search != null && search.isNotEmpty) 'search': search!,
//         },
//       );

//       print('Response data: ${response.data}'); // Log raw response data

//       if (response.data == null) {
//         return Left(ServerFailure(message: 'Response data is null'));
//       }

//       if (response.data is! Map<String, dynamic>) {
//         return Left(
//           ServerFailure(
//             message: 'Unexpected response format: ${response.data.runtimeType}',
//           ),
//         );
//       }

//       final apiModel = LessonResponseModel.fromJson(response.data);
//       return Right(apiModel);
//     } on DioError catch (e) {
//       return Left(ServerFailure(message: e.message ?? 'Unknown error'));
//     }
//   }

//   // Future<Either<Failure, LessonModel>> getLessonById(String id) async {
//   //   try {
//   //     final response = await dio.get('/lessons/$id');
//   //     final apiModel = LessonModel.fromJson(response.data['data']);
//   //     // final apiModel = LessonModel.fromJson(response.data);
//   //     return Right(apiModel);
//   //   } on DioError catch (e) {
//   //     return Left(ServerFailure(message: e.message ?? 'Unknown error'));
//   //   }
//   // }
//   @override
//   Future<Either<Failure, LessonModel>> getLessonById(String id) async {
//     try {
//       // Using the current endpoint that returns all lessons
//       final response = await dio.get('/api/admin/lesson/');

//       // Extract the lessons array from the response
//       final List<dynamic> lessonsData = response.data['data'];

//       // Find the specific lesson by ID
//       final lessonData = lessonsData.firstWhere(
//         (lesson) => lesson['_id'] == id,
//         orElse: () => null,
//       );

//       if (lessonData == null) {
//         return Left(ServerFailure(message: 'Lesson not found'));
//       }

//       // Create the lesson model from the found lesson data
//       final apiModel = LessonModel.fromJson(lessonData);
//       return Right(apiModel);
//     } on DioError catch (e) {
//       return Left(ServerFailure(message: e.message ?? 'Unknown error'));
//     } catch (e) {
//       return Left(ServerFailure(message: 'Unexpected error: ${e.toString()}'));
//     }
//   }
// }
