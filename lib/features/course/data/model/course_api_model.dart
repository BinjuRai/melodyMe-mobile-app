import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entity/course_entity.dart';

part 'course_api_model.g.dart'; // Run: dart run build_runner build -d

@JsonSerializable()
class CourseApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final double totalPrice;
  final String? filepath;

  const CourseApiModel({
    required this.id,
    required this.name,
    required this.totalPrice,
    this.filepath,
  });

  /// From JSON
  factory CourseApiModel.fromJson(Map<String, dynamic> json) =>
      _$CourseApiModelFromJson(json);

  /// To JSON
  Map<String, dynamic> toJson() => _$CourseApiModelToJson(this);

  /// To Entity
  CourseEntity toEntity() {
    return CourseEntity(
      id: id,
      name: name,
      totalPrice: totalPrice,
      filepath: filepath,
    );
  }

  /// From Entity
  factory CourseApiModel.fromEntity(CourseEntity entity) {
    return CourseApiModel(
      id: entity.id,
      name: entity.name,
      totalPrice: entity.totalPrice,
      filepath: entity.filepath,
    );
  }

  @override
  List<Object?> get props => [id, name, totalPrice, filepath];
}
