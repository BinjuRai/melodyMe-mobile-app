import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';

class Wishlist {
  final String userId;
  final List<LessonEntity> lessons;

  Wishlist({
    required this.userId,
    required this.lessons,
  });
}