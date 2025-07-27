// import 'package:json_annotation/json_annotation.dart';
// import 'package:batch34_b/features/lesson/data/model/lesson_api_model.dart';

// part 'wishlist_api_model.g.dart';

// @JsonSerializable()
// class WishlistApiModel {
//   @JsonKey(name: 'user_id')
//   final String userId;
  
//   @JsonKey(name: 'lessons')
//   final List<LessonModel> lessons;

//   WishlistApiModel({
//     required this.userId,
//     required this.lessons,
//   });

//   factory WishlistApiModel.fromJson(Map<String, dynamic> json) =>
//       _$WishlistApiModelFromJson(json);

//   Map<String, dynamic> toJson() => _$WishlistApiModelToJson(this);
// }
import 'package:batch34_b/features/lesson/data/model/lesson_api_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'wishlist_api_model.g.dart';
@JsonSerializable()
class WishlistApiModel {
  final bool success;

  final List<LessonModel> lessons;

  WishlistApiModel({
    required this.success,
    required this.lessons,
  });

  factory WishlistApiModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistApiModelToJson(this);
}
