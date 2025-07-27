import 'package:json_annotation/json_annotation.dart';

part 'lesson_info_model.g.dart';

@JsonSerializable()
class LessonInfo {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final double price;

  LessonInfo({required this.id, required this.title, required this.price});

  factory LessonInfo.fromJson(Map<String, dynamic> json) =>
      _$LessonInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LessonInfoToJson(this);
}
