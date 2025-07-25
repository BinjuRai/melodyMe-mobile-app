// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonPaginationModel _$LessonPaginationModelFromJson(
        Map<String, dynamic> json) =>
    LessonPaginationModel(
      currentPage: (json['currentPage'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      totalItems: (json['totalItems'] as num).toInt(),
      itemsPerPage: (json['itemsPerPage'] as num).toInt(),
      hasNext: json['hasNext'] as bool,
      hasPrev: json['hasPrev'] as bool,
    );

Map<String, dynamic> _$LessonPaginationModelToJson(
        LessonPaginationModel instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'totalPages': instance.totalPages,
      'totalItems': instance.totalItems,
      'itemsPerPage': instance.itemsPerPage,
      'hasNext': instance.hasNext,
      'hasPrev': instance.hasPrev,
    };
