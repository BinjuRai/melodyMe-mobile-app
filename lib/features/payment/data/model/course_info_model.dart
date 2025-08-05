import 'package:json_annotation/json_annotation.dart';

part 'course_info_model.g.dart';

@JsonSerializable()
class CourseInfo {
  @JsonKey(name: '_id')
  final String id;
  final String title;

  CourseInfo({required this.id, required this.title});

  factory CourseInfo.fromJson(Map<String, dynamic> json) =>
      _$CourseInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CourseInfoToJson(this);
}
