import 'package:batch34_b/features/lesson/data/model/lesson_api_model.dart';
import 'package:batch34_b/features/lesson/data/model/pagination_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

// Use alias to avoid ambiguous import
import 'package:batch34_b/features/lesson/domain/entity/lesson_response.dart' as domain;

part 'lesson_response_api_model.g.dart';

@JsonSerializable()
class LessonResponseModel {
  final List<LessonModel> lessons;
  final LessonPaginationModel pagination;

  LessonResponseModel({
    required this.lessons,
    required this.pagination,
  });

  factory LessonResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LessonResponseModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$LessonResponseModelToJson(this);

  /// Convert API model to domain entity
  domain.LessonResponse toEntity() {
    return domain.LessonResponse(
      lessons: lessons.map((lesson) => lesson.toEntity()).toList(),
      pagination: pagination.toEntity(),
    );
  }
}