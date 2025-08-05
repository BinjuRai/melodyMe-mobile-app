// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:batch34_b/features/lesson/data/model/lesson_hive_model.dart';

// abstract class WishlistLocalDataSource {
//   Future<List<LessonHiveModel>> getWishlistLessons(String userId);
//   Future<void> addLessonToWishlist(String userId, LessonHiveModel lesson);
//   Future<void> removeLessonFromWishlist(String userId, String lessonId);
//   Future<void> clearWishlist(String userId);
// }

// class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
//   final Box<List> wishlistBox;
  
//   WishlistLocalDataSourceImpl({required this.wishlistBox});

//   String _getWishlistKey(String userId) => 'wishlist_$userId';

//   @override
//   Future<List<LessonHiveModel>> getWishlistLessons(String userId) async {
//     try {
//       final key = _getWishlistKey(userId);
//       final List<dynamic>? storedLessons = wishlistBox.get(key);
      
//       if (storedLessons == null) return [];
      
//       return storedLessons
//           .map((lesson) => LessonHiveModel.fromJson(Map<String, dynamic>.from(lesson)))
//           .toList();
//     } catch (e) {
//       throw Exception('Failed to get wishlist from local storage: $e');
//     }
//   }

//   @override
//   Future<void> addLessonToWishlist(String userId, LessonHiveModel lesson) async {
//     try {
//       final key = _getWishlistKey(userId);
//       final existingLessons = await getWishlistLessons(userId);
      
//       // Check if lesson already exists
//       final lessonExists = existingLessons.any((l) => l.id == lesson.id);
//       if (lessonExists) return;
      
//       existingLessons.add(lesson);
//       final jsonList = existingLessons.map((l) => l.toJson()).toList();
      
//       await wishlistBox.put(key, jsonList);
//     } catch (e) {
//       throw Exception('Failed to add lesson to wishlist: $e');
//     }
//   }

//   @override
//   Future<void> removeLessonFromWishlist(String userId, String lessonId) async {
//     try {
//       final key = _getWishlistKey(userId);
//       final existingLessons = await getWishlistLessons(userId);
      
//       existingLessons.removeWhere((lesson) => lesson.id == lessonId);
//       final jsonList = existingLessons.map((l) => l.toJson()).toList();
      
//       await wishlistBox.put(key, jsonList);
//     } catch (e) {
//       throw Exception('Failed to remove lesson from wishlist: $e');
//     }
//   }

//   @override
//   Future<void> clearWishlist(String userId) async {
//     try {
//       final key = _getWishlistKey(userId);
//       await wishlistBox.delete(key);
//     } catch (e) {
//       throw Exception('Failed to clear wishlist: $e');
//     }
//   }
// }
