// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_lesson_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishLessonModel _$WishLessonModelFromJson(Map<String, dynamic> json) =>
    WishLessonModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      authorName: json['authorName'] as String?,
      duration: json['duration'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      courseId: json['courseId'] as String?,
      sellerId: json['sellerId'] as String?,
      imagepath: json['imagepath'] as String?,
      filepath: json['filepath'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$WishLessonModelToJson(WishLessonModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'authorName': instance.authorName,
      'duration': instance.duration,
      'price': instance.price,
      'courseId': instance.courseId,
      'sellerId': instance.sellerId,
      'imagepath': instance.imagepath,
      'filepath': instance.filepath,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
