import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/core/network/api_service.dart';
import 'package:batch34_b/features/lesson/data/model/lesson_api_model.dart';
import 'package:dio/dio.dart';

// abstract class CourseLessonRemoteRepository {
//   Future<List<LessonModel>> fetchLessonsByCourse(String courseId);
// }

class CourseLessonRemoteRepository {
  final ApiService apiService;

  CourseLessonRemoteRepository({required this.apiService});

  Future<List<LessonModel>> fetchLessonsByCourse(String courseId) async {
    try {
      final response = await apiService.dio.get(
        '${ApiEndpoints.baseUrl}/lesson/course/$courseId',
      );

      final data = response.data['data'];
      if (data is List) {
        return data.map((json) => LessonModel.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } on DioException catch (e) {
      print('❌ DioException caught: $e');
      rethrow;
    }
  }
}
