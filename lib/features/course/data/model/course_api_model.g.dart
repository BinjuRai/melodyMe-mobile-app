// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseApiModel _$CourseApiModelFromJson(Map<String, dynamic> json) =>
    CourseApiModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      filepath: json['filepath'] as String?,
    );

Map<String, dynamic> _$CourseApiModelToJson(CourseApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'totalPrice': instance.totalPrice,
      'filepath': instance.filepath,
    };
