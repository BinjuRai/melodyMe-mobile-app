// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonInfo _$LessonInfoFromJson(Map<String, dynamic> json) => LessonInfo(
      id: json['_id'] as String,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$LessonInfoToJson(LessonInfo instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'price': instance.price,
    };
