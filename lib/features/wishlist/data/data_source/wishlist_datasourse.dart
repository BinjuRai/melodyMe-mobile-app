
import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/lesson/data/model/lesson_api_model.dart';
import 'package:dartz/dartz.dart';

abstract class WishlistRemoteDataSource {
  Future<List<LessonModel>> getWishlistLessons(String userId);
  Future<void> addLessonToWishlist(String userId, LessonModel lesson);
  Future<void> removeLessonFromWishlist(String userId, String lessonId);
  Future<LessonModel> getLessonById(String lessonId);
}