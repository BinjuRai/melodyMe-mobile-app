import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson_api_model.g.dart';

@JsonSerializable()
class LessonModel {
  @JsonKey(name: '_id')
  final String id;
  
  final String name;
  final String description;
  final String authorName;
  final String duration;
  final double price;
  
  @JsonKey(name: 'courseId')
  final CourseInfo? courseInfo;
  
  @JsonKey(name: 'sellerId')
  final SellerInfo sellerInfo;
  
  final String imagepath;
  final String filepath;
  final String createdAt;
  final String updatedAt;

  LessonModel({
    required this.id,
    required this.name,
    required this.description,
    required this.authorName,
    required this.duration,
    required this.price,
    this.courseInfo,
    required this.sellerInfo,
    required this.imagepath,
    required this.filepath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$LessonModelToJson(this);

  /// Convert API model to domain entity
  LessonEntity toEntity() {
    return LessonEntity(
      id: id,
      name: name,
      description: description,
      authorName: authorName,
      duration: duration,
      price: price,
      courseId: courseInfo?.id,
      courseName: courseInfo?.name,
      sellerId: sellerInfo.id,
      sellerName: sellerInfo.firstName,
      sellerEmail: sellerInfo.email,
      imagePath: imagepath,
      filePath: filepath,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
    );
  }
}

@JsonSerializable()
class CourseInfo {
  @JsonKey(name: '_id')
  final String id;
  final String name;

  CourseInfo({
    required this.id,
    required this.name,
  });

  factory CourseInfo.fromJson(Map<String, dynamic> json) =>
      _$CourseInfoFromJson(json);
  
  Map<String, dynamic> toJson() => _$CourseInfoToJson(this);
}

@JsonSerializable()
class SellerInfo {
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String email;

  SellerInfo({
    required this.id,
    required this.firstName,
    required this.email,
  });

  factory SellerInfo.fromJson(Map<String, dynamic> json) =>
      _$SellerInfoFromJson(json);
  
  Map<String, dynamic> toJson() => _$SellerInfoToJson(this);
}