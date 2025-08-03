import 'package:batch34_b/app/share_pref/token_shared_pref.dart';
import 'package:batch34_b/features/lesson/data/model/lesson_api_model.dart';
import 'package:batch34_b/features/wishlist/data/data_source/wishlist_datasourse.dart';
import 'package:batch34_b/features/wishlist/data/model/wish_lesson_api_model.dart';
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
  Future<List<WishLessonModel>> getWishlistLessons(String userId) async {
    try {
      final options = await _getAuthOptions();

      // Adjust endpoint if needed, e.g. no userId in URL if API doesn't require it
      final response = await dio.get(baseUrl, options: options);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['lessons'] ?? [];
        return data.map((json) => WishLessonModel.fromJson(json)).toList();
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
        requestOptions: RequestOptions(path: baseUrl),
        message: 'Unexpected error: $e',
      );
    }
  }

  @override
  Future<void> addLessonToWishlist(
    String userId,
    WishLessonModel lesson,
  ) async {
    try {
      final options = await _getAuthOptions();

      final body = {'lessonId': lesson.id};

      print('Sending lesson to wishlist: $body'); // Simple print for debug

      final response = await dio.post(
        baseUrl, // This should be 'http://localhost:5050/api/normal/wishlist'
        data: body,
        options: options,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          message: 'Failed to add lesson to wishlist',
        );
      }
    } on DioException catch (e) {
      print('Dio error: ${e.response?.data}'); // Use print here too
      rethrow;
    } catch (e) {
      throw DioException(
        requestOptions: RequestOptions(path: baseUrl),
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
