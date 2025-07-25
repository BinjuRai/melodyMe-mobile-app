import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pagination_api_model.g.dart';

@JsonSerializable()
class LessonPaginationModel {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final bool hasNext;
  final bool hasPrev;

  LessonPaginationModel({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.hasNext,
    required this.hasPrev,
  });

  factory LessonPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$LessonPaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LessonPaginationModelToJson(this);

  /// Convert API model to domain entity
  LessonPagination toEntity() {
    return LessonPagination(
      currentPage: currentPage,
      totalPages: totalPages,
      totalItems: totalItems,
      itemsPerPage: itemsPerPage,
      hasNext: hasNext,
      hasPrev: hasPrev,
    );
  }
}
