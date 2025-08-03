// import 'dart:io';

// import 'package:batch34_b/app/constant/api_endpoints.dart';
// import 'package:batch34_b/core/network/api_service.dart';
// import 'package:batch34_b/features/course/data/data_source/remote_datasource/course_remote_datasource.dart';
// import 'package:batch34_b/features/course/data/model/course_api_model.dart';
// import 'package:batch34_b/features/lesson/data/model/lesson_api_model.dart';
// import 'package:dio/dio.dart';

// class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
//   final ApiService apiService;

//   CourseRemoteDataSourceImpl({required this.apiService});

//   // Fix double slash by checking trailing slash in baseUrl
//   final String baseUrl =
//       ApiEndpoints.baseUrl.endsWith('/')
//           ? '${ApiEndpoints.baseUrl}course'
//           : '${ApiEndpoints.baseUrl}/course';

//   @override
//   Future<List<CourseApiModel>> getAllCourses() async {
//     try {
//       final response = await apiService.dio.get(ApiEndpoints.getAllCourse);
//       final data = response.data['data'] as List;
//       return data.map((e) => CourseApiModel.fromJson(e)).toList();
//     } on DioException catch (e) {
//       throw Exception(_handleDioError(e));
//     }
//   }

//   @override
//   Future<CourseApiModel> getCourseById(String id) async {
//     try {
//       final response = await apiService.dio.get('$baseUrl/$id');
//       final data = response.data['data'];
//       return CourseApiModel.fromJson(data);
//     } on DioException catch (e) {
//       throw Exception(_handleDioError(e));
//     }
//   }

//   @override
//   Future<void> deleteCourse(String id) async {
//     try {
//       await apiService.dio.delete('$baseUrl/$id');
//     } on DioException catch (e) {
//       throw Exception(_handleDioError(e));
//     }
//   }

//   @override
//   Future<CourseApiModel> createCourse(String name, File? image) async {
//     try {
//       final formData = FormData.fromMap({
//         'name': name,
//         if (image != null)
//           'image': await MultipartFile.fromFile(
//             image.path,
//             filename: image.path.split('/').last,
//           ),
//       });

//       final response = await apiService.dio.post(baseUrl, data: formData);
//       return CourseApiModel.fromJson(response.data['data']);
//     } on DioException catch (e) {
//       throw Exception(_handleDioError(e));
//     }
//   }

//   @override
//   Future<CourseApiModel> updateCourse(
//     String id,
//     String name, {
//     File? image,
//   }) async {
//     try {
//       final formData = FormData.fromMap({
//         'name': name,
//         if (image != null)
//           'image': await MultipartFile.fromFile(
//             image.path,
//             filename: image.path.split('/').last,
//           ),
//       });

//       final response = await apiService.dio.put('$baseUrl/$id', data: formData);
//       return CourseApiModel.fromJson(response.data['data']);
//     } on DioException catch (e) {
//       throw Exception(_handleDioError(e));
//     }
//   }

//   @override
//   Future<List<LessonModel>> getLessonsByCourse(String courseId) async {
//     try {
//       final url = '$baseUrl/$courseId/lessons';
//       print('Fetching lessons from URL: $url');

//       final response = await apiService.dio.get(url);
//       final data = response.data['data'] as List;
//       return data.map((e) => LessonModel.fromJson(e)).toList();
//     } on DioException catch (e) {
//       throw Exception(_handleDioError(e));
//     }
//   }

//   String _handleDioError(DioException e) {
//     if (e.response != null) {
//       return 'Error ${e.response?.statusCode}: ${e.response?.data['message'] ?? e.message}';
//     } else {
//       return 'Network error: ${e.message}';
//     }
//   }
// }
import 'dart:io';
import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/core/network/api_service.dart';
import 'package:batch34_b/features/course/data/data_source/remote_datasource/course_remote_datasource.dart';
import 'package:batch34_b/features/course/data/model/course_api_model.dart';
import 'package:batch34_b/features/lesson/data/model/lesson_api_model.dart';
import 'package:dio/dio.dart';

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final ApiService apiService;

  CourseRemoteDataSourceImpl({required this.apiService});

  final String baseUrl =
      ApiEndpoints.baseUrl.endsWith('/')
          ? '${ApiEndpoints.baseUrl}admin/courses'
          : '${ApiEndpoints.baseUrl}/admin/courses';

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

  // IMPLEMENT THIS METHOD! This is crucial to avoid UnimplementedError
  // @override
  // Future<List<LessonModel>> getLessonsByCourse(String courseId) async {
  //   try {
  //     final response = await apiService.dio.get('$baseUrl/$courseId/lessons');
  //     final data = response.data['data'] as List;
  //     return data.map((e) => LessonModel.fromJson(e)).toList();
  //   } on DioException catch (e) {
  //     throw Exception(_handleDioError(e));
  //   }
  // }
  @override
  Future<List<LessonModel>> getLessonsByCourse(String courseId) async {
    try {
      final endpoint = ApiEndpoints.getCourseLessons.replaceAll(
        ':id',
        courseId,
      );
      print('📦 getLessonsByCourse called with courseId: $courseId');
      print('🌐 Fetching lessons from: $endpoint');
      print('🔍 Full URL will be: ${ApiEndpoints.baseUrl}$endpoint');

      final response = await apiService.dio.get(endpoint);

      print('🔍 Response status code: ${response.statusCode}');
      print('🔍 Response data runtime type: ${response.data.runtimeType}');
      print('🔍 Raw response data: ${response.data}');

      // Handle different response structures
      List<dynamic> data;
      if (response.data is List) {
        data = response.data;
      } else if (response.data is Map && response.data['data'] is List) {
        data = response.data['data'];
      } else if (response.data is Map && response.data['lessons'] is List) {
        data = response.data['lessons'];
      } else if (response.data is Map &&
          response.data['data'] is Map &&
          response.data['data']['lessons'] is List) {
        data = response.data['data']['lessons'];
      } else {
        throw Exception(
          'Unexpected response format for lessons: ${response.data.runtimeType}',
        );
      }

      print('🔍 Number of lessons: ${data.length}');

      // Parse lessons with individual error handling
      List<LessonModel> lessons = [];
      for (int i = 0; i < data.length; i++) {
        try {
          print('🔍 Parsing lesson $i: ${data[i]}');
          final lesson = LessonModel.fromJson(data[i]);
          lessons.add(lesson);
          print('✅ Successfully parsed lesson $i: ${lesson.toString()}');
        } catch (e, stackTrace) {
          print('❌ Error parsing lesson $i: $e');
          print('📍 Stack trace: $stackTrace');
          print('🔍 Problematic lesson data: ${data[i]}');
          print('🔍 Lesson data type: ${data[i].runtimeType}');
          rethrow;
        }
      }

      return lessons;
    } on DioException catch (e) {
      print('❌ DioException caught: $e');
      throw Exception(_handleDioError(e));
    } catch (e, stackTrace) {
      print('❌ General error in getLessonsByCourse: $e');
      print('📍 Stack trace: $stackTrace');
      rethrow;
    }
  }

  String _handleDioError(DioException e) {
    try {
      print('🔍 Handling DioException: ${e.type}');
      print('🔍 DioException message: ${e.message}');
      print('🔍 DioException response: ${e.response}');

      if (e.response != null) {
        final statusCode = e.response?.statusCode;
        final responseData = e.response?.data;

        print('🔍 Response status code: $statusCode');
        print('🔍 Response data: $responseData');
        print('🔍 Response data type: ${responseData.runtimeType}');

        String message = 'Unknown error';
        if (responseData is Map) {
          if (responseData['message'] != null) {
            message = responseData['message'].toString();
          } else if (responseData['error'] != null) {
            message = responseData['error'].toString();
          }
        }

        if (message == 'Unknown error' && e.message != null) {
          message = e.message!;
        }

        return 'Error $statusCode: $message';
      } else {
        // Handle network errors (like connection refused, timeout, etc.)
        String errorMessage = 'Unknown network error';

        if (e.type == DioExceptionType.connectionTimeout) {
          errorMessage = 'Connection timeout - server may be down';
        } else if (e.type == DioExceptionType.receiveTimeout) {
          errorMessage = 'Receive timeout - server response too slow';
        } else if (e.type == DioExceptionType.sendTimeout) {
          errorMessage = 'Send timeout - request too slow';
        } else if (e.type == DioExceptionType.connectionError) {
          errorMessage = 'Connection error - cannot reach server';
        } else if (e.message != null) {
          errorMessage = e.message!;
        }

        return 'Network error: $errorMessage';
      }
    } catch (error, stackTrace) {
      print('❌ Error in _handleDioError itself: $error');
      print('📍 Stack trace: $stackTrace');
      return 'Error handling failed: $error';
    }
  }
}
