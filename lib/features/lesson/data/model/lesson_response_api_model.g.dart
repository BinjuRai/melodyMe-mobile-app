// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_response_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonResponseModel _$LessonResponseModelFromJson(Map<String, dynamic> json) =>
    LessonResponseModel(
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: LessonPaginationModel.fromJson(
          json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LessonResponseModelToJson(
        LessonResponseModel instance) =>
    <String, dynamic>{
      'lessons': instance.lessons,
      'pagination': instance.pagination,
    };
