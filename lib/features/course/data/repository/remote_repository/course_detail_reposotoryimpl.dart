// to fetch lesson by course id this file i useddddddddddd
import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/core/network/api_service.dart';
import 'package:dio/dio.dart';
import 'package:batch34_b/features/lesson/data/model/lesson_api_model.dart';
import 'package:batch34_b/features/course/data/repository/remote_repository/course_lesson_remote_repository.dart';

class CourseLessonRemoteRepositoryImpl implements CourseLessonRemoteRepository {
  final ApiService _apiService;

  CourseLessonRemoteRepositoryImpl(this._apiService);

  @override
  Future<List<LessonModel>> fetchLessonsByCourse(String courseId) async {
    try {
      final response = await _apiService.dio.get(
        '${ApiEndpoints.baseUrl}admin/courses/$courseId/lessons',
      );

      print('🔍 response.data.runtimeType: ${response.data.runtimeType}');
      print('🔍 Raw response data: ${response.data}');
      print('🔍 Status code: ${response.statusCode}');

      final dynamic rawData = response.data['data'];

      if (rawData is List) {
        return rawData.map((e) => LessonModel.fromJson(e)).toList();
      } else {
        throw Exception('Unexpected response format: "data" is not a List');
      }
    } on DioException catch (e) {
      print('❌ DioException caught: $e');
      rethrow;
    }
  }

  @override
  ApiService get apiService => _apiService;
}
