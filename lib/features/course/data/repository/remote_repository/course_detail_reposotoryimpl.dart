import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/core/network/api_service.dart';
import 'package:dio/dio.dart';
import 'package:batch34_b/features/lesson/data/model/lesson_api_model.dart';
import 'package:batch34_b/features/course/data/repository/remote_repository/course_lesson_remote_repository.dart';

class CourseLessonRemoteRepositoryImpl implements CourseLessonRemoteRepository {
  final Dio dio;

  CourseLessonRemoteRepositoryImpl(this.dio);

  @override
  //   Future<List<LessonModel>> fetchLessonsByCourse(String courseId) async {
  //     print('🌐 Fetching lessons for courseId: $courseId');
  //     final response = await dio.get('/lesson/course/$courseId');
  //     print('🔍 Raw response: ${response.data}');
  //     // final data = response.data as List;
  //     final data = response.data['data']['lessons'] as List;
  //     return data.map((json) => LessonModel.fromJson(json)).toList();
  //   }
  // }
  Future<List<LessonModel>> fetchLessonsByCourse(String courseId) async {
    try {
      final response = await apiService.dio.get(
        '${ApiEndpoints.baseUrl}/lesson/course/$courseId',
      );
      print('🔍 Raw response data: ${response.data}');
      // Also print the full response to check headers and status code
      print('🔍 Response status code: ${response.statusCode}');
      return (response.data['data'] as List)
          .map((e) => LessonModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      print('❌ DioException caught: $e');
      rethrow;
    }
  }

  @override
  // TODO: implement apiService
  ApiService get apiService => throw UnimplementedError();
}
