import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wish_lesson_api_model.g.dart';

@JsonSerializable()
class WishLessonModel {
  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  final String? description;
  final String? authorName;
  final String? duration;
  final double? price;

  @JsonKey(name: 'courseId')
  final String? courseId;

  @JsonKey(name: 'sellerId')
  final String? sellerId;

  final String? imagepath;
  final String? filepath;
  final String? createdAt;
  final String? updatedAt;

  WishLessonModel({
    this.id,
    this.name,
    this.description,
    this.authorName,
    this.duration,
    this.price,
    this.courseId,
    this.sellerId,
    this.imagepath,
    this.filepath,
    this.createdAt,
    this.updatedAt,
  });

  factory WishLessonModel.fromJson(Map<String, dynamic> json) =>
      _$WishLessonModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishLessonModelToJson(this);

  LessonEntity toEntity() {
    return LessonEntity(
      id: id ?? '',
      name: name ?? '',
      description: description ?? '',
      authorName: authorName ?? '',
      duration: duration ?? '',
      price: price ?? 0.0,
      courseId: courseId,
      courseName: null,
      sellerId: sellerId,
      sellerName: null,
      sellerEmail: null,
      imagePath: imagepath ?? '',
      filePath: filepath ?? '',
      createdAt:
          createdAt != null
              ? DateTime.tryParse(createdAt!) ?? DateTime.now()
              : DateTime.now(),
      updatedAt:
          updatedAt != null
              ? DateTime.tryParse(updatedAt!) ?? DateTime.now()
              : DateTime.now(),
    );
  }
}
