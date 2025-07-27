import 'package:batch34_b/app/share_pref/token_shared_pref.dart';
import 'package:batch34_b/features/lesson/data/model/lesson_api_model.dart';
import 'package:batch34_b/features/wishlist/data/data_source/wishlist_datasourse.dart';
import 'package:dio/dio.dart';

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  final Dio dio;
  final TokenSharedPrefs tokenPrefs;

  static const String baseUrl = '/normal/wishlist';

  WishlistRemoteDataSourceImpl({required this.dio, required this.tokenPrefs});

  Future<Options> _getAuthOptions() async {
    final tokenResult = await tokenPrefs.getToken();

    return tokenResult.fold(
      (failure) => throw Exception("Token error: ${failure.message}"),
      (token) {
        if (token == null) throw Exception("Token not found");
        return Options(headers: {'Authorization': 'Bearer $token'});
      },
    );
  }

  @override
  Future<List<LessonModel>> getWishlistLessons(String userId) async {
    try {
      final options = await _getAuthOptions();
      final response = await dio.get('$baseUrl/$userId', options: options);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['lessons'] ?? [];
        for (var item in data) {
          print('Item type: ${item.runtimeType}, value: $item');
        }
        return data.map((json) => LessonModel.fromJson(json)).toList();
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to get wishlist lessons',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '$baseUrl/$userId'),
        message: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<void> addLessonToWishlist(String userId, LessonModel lesson) async {
    try {
      final options = await _getAuthOptions();
      final response = await dio.post(
        '$baseUrl/$userId/lessons',
        data: {'lesson_id': lesson.id},
        options: options,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to add lesson to wishlist',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: '$baseUrl/$userId/lessons'),
        message: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<void> removeLessonFromWishlist(String userId, String lessonId) async {
    try {
      final options = await _getAuthOptions();
      final response = await dio.delete(
        '$baseUrl/$userId/lessons/$lessonId',
        options: options,
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to remove lesson from wishlist',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(
          path: '$baseUrl/$userId/lessons/$lessonId',
        ),
        message: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<LessonModel> getLessonById(String lessonId) async {
    try {
      final options = await _getAuthOptions();
      final response = await dio.get('lessons/$lessonId', options: options);

      if (response.statusCode == 200) {
        return LessonModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to get lesson by id',
        );
      }
    } on DioException {
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: 'lessons/$lessonId'),
        message: 'Unexpected error: $e',
      );
    }
  }
}
