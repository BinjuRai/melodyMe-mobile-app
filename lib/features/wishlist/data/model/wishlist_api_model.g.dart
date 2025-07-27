// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistApiModel _$WishlistApiModelFromJson(Map<String, dynamic> json) =>
    WishlistApiModel(
      success: json['success'] as bool,
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WishlistApiModelToJson(WishlistApiModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'lessons': instance.lessons,
    };
