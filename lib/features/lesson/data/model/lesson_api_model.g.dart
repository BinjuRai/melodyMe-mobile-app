// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      authorName: json['authorName'] as String?,
      duration: json['duration'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      courseInfo: json['courseId'] == null
          ? null
          : CourseInfo.fromJson(json['courseId'] as Map<String, dynamic>),
      sellerInfo: json['sellerId'] == null
          ? null
          : SellerInfo.fromJson(json['sellerId'] as Map<String, dynamic>),
      imagepath: json['imagepath'] as String?,
      filepath: json['filepath'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$LessonModelToJson(LessonModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'authorName': instance.authorName,
      'duration': instance.duration,
      'price': instance.price,
      'courseId': instance.courseInfo,
      'sellerId': instance.sellerInfo,
      'imagepath': instance.imagepath,
      'filepath': instance.filepath,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

CourseInfo _$CourseInfoFromJson(Map<String, dynamic> json) => CourseInfo(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$CourseInfoToJson(CourseInfo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };

SellerInfo _$SellerInfoFromJson(Map<String, dynamic> json) => SellerInfo(
      id: json['_id'] as String?,
      firstName: json['firstName'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$SellerInfoToJson(SellerInfo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'email': instance.email,
    };
