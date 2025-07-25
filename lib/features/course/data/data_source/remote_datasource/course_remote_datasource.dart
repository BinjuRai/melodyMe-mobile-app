import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:batch34_b/core/network/api_service.dart';
import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/features/course/data/model/course_api_model.dart';

abstract class CourseRemoteDataSource {
  Future<List<CourseApiModel>> getAllCourses();
  Future<CourseApiModel> getCourseById(String id);
  Future<void> deleteCourse(String id);
  Future<CourseApiModel> createCourse(String name, File? image);
  Future<CourseApiModel> updateCourse(String id, String name, {File? image});
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final ApiService apiService;

  CourseRemoteDataSourceImpl({required this.apiService});

  final String baseUrl = '${ApiEndpoints.baseUrl}course';

  @override
  Future<List<CourseApiModel>> getAllCourses() async {
    try {
      final response = await apiService.dio.get(ApiEndpoints.getAllCourse);
      final data = response.data['data'] as List;
      return data.map((e) => CourseApiModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  @override
  Future<CourseApiModel> getCourseById(String id) async {
    try {
      final response = await apiService.dio.get('$baseUrl/$id');

      final data = response.data['data'];
      return CourseApiModel.fromJson(data);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  @override
  Future<void> deleteCourse(String id) async {
    try {
      await apiService.dio.delete('$baseUrl/$id');
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  @override
  Future<CourseApiModel> createCourse(String name, File? image) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });

      final response = await apiService.dio.post(baseUrl, data: formData);
      return CourseApiModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  @override
  Future<CourseApiModel> updateCourse(
    String id,
    String name, {
    File? image,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        if (image != null)
          'image': await MultipartFile.fromFile(
            image.path,
            filename: image.path.split('/').last,
          ),
      });

      final response = await apiService.dio.put('$baseUrl/$id', data: formData);
      return CourseApiModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw Exception(_handleDioError(e));
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null) {
      return 'Error ${e.response?.statusCode}: ${e.response?.data['message'] ?? e.message}';
    } else {
      return 'Network error: ${e.message}';
    }
  }
}
