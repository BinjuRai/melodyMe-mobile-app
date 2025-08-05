// import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
// import 'package:json_annotation/json_annotation.dart';

// part 'lesson_api_model.g.dart';

// @JsonSerializable()
// class LessonModel {
//   @JsonKey(name: '_id')
//   final String? id;

//   final String? name;
//   final String? description;
//   final String? authorName;
//   final String? duration;
//   final double? price;

//   @JsonKey(name: 'courseId')
//   final CourseInfo? courseInfo;

//   @JsonKey(name: 'sellerId')
//   final SellerInfo? sellerInfo;

//   final String? imagepath;
//   final String? filepath;
//   final String? createdAt;
//   final String? updatedAt;

//   LessonModel({
//     this.id,
//     this.name,
//     this.description,
//     this.authorName,
//     this.duration,
//     this.price,
//     this.courseInfo,
//     this.sellerInfo,
//     this.imagepath,
//     this.filepath,
//     this.createdAt,
//     this.updatedAt,
//   });

//   // factory LessonModel.fromJson(Map<String, dynamic> json) =>
//   //     _$LessonModelFromJson(json);
//   factory LessonModel.fromJson(Map<String, dynamic> json) {

//     // Handle courseId (can be Map or List)
//     // final courseRaw = json['courseId'];
//     // CourseInfo? courseInfo;
//     // if (courseRaw is Map<String, dynamic>) {
//     //   courseInfo = CourseInfo.fromJson(courseRaw);
//     // } else if (courseRaw is List &&
//     //     courseRaw.isNotEmpty &&
//     //     courseRaw.first is Map<String, dynamic>) {
//     //   courseInfo = CourseInfo.fromJson(courseRaw.first);
//     // }final courseRaw = json['courseId'];
// CourseInfo? courseInfo;
//   final courseRaw = json['courseId'];
// if (courseRaw is Map<String, dynamic>) {
//   courseInfo = CourseInfo.fromJson(courseRaw);
// } else if (courseRaw is List && courseRaw.isNotEmpty) {
//   final first = courseRaw.first;
//   if (first is Map<String, dynamic>) {
//     courseInfo = CourseInfo.fromJson(first);
//   } else {
//     print('⚠️ Unexpected item in courseId list: $first');
//   }
// } else if (courseRaw is String) {
//   print('ℹ️ courseId is a plain String ID: $courseRaw');
//   // Optional: set a dummy CourseInfo or leave null
//   courseInfo = CourseInfo(id: courseRaw, name: '');
// } else if (courseRaw == null) {
//   print('ℹ️ courseId is null');
// } else {
//   print('❗ Unexpected courseId type: ${courseRaw.runtimeType}');
// }

//     // Handle sellerId (can be Map<String, dynamic> or List<Map>)
//     final sellerRaw = json['sellerId'];
//     SellerInfo? sellerInfo;
//     if (sellerRaw is Map<String, dynamic>) {
//       sellerInfo = SellerInfo.fromJson(sellerRaw);
//     } else if (sellerRaw is List &&
//         sellerRaw.isNotEmpty &&
//         sellerRaw.first is Map<String, dynamic>) {
//       sellerInfo = SellerInfo.fromJson(sellerRaw.first);
//     }

//     return LessonModel(
//       id: json['_id'] as String?,
//       name: json['name'] as String?,
//       description: json['description'] as String?,
//       authorName: json['authorName'] as String?,
//       duration: json['duration'] as String?,
//       price: (json['price'] as num?)?.toDouble(),
//       courseInfo: courseInfo,
//       sellerInfo: sellerInfo,
//       imagepath: json['imagepath'] as String?,
//       filepath: json['filepath'] as String?,
//       createdAt: json['createdAt'] as String?,
//       updatedAt: json['updatedAt'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() => _$LessonModelToJson(this);

//   LessonEntity toEntity() {
//     return LessonEntity(
//       id: id ?? '',
//       name: name ?? '',
//       description: description ?? '',
//       authorName: authorName ?? '',
//       duration: duration ?? '',
//       price: price ?? 0.0,
//       courseId: courseInfo?.id,
//       courseName: courseInfo?.name,
//       sellerId: sellerInfo?.id,
//       sellerName: sellerInfo?.firstName,
//       sellerEmail: sellerInfo?.email,
//       imagePath: imagepath ?? '',
//       filePath: filepath ?? '',
//       createdAt:
//           createdAt != null
//               ? DateTime.tryParse(createdAt!) ?? DateTime.now()
//               : DateTime.now(),
//       updatedAt:
//           updatedAt != null
//               ? DateTime.tryParse(updatedAt!) ?? DateTime.now()
//               : DateTime.now(),
//     );
//   }
// }

// @JsonSerializable()
// class CourseInfo {
//   @JsonKey(name: '_id')
//   final String? id;
//   final String? name;

//   CourseInfo({this.id, this.name});

//   factory CourseInfo.fromJson(Map<String, dynamic> json) =>
//       _$CourseInfoFromJson(json);

//   Map<String, dynamic> toJson() => _$CourseInfoToJson(this);
// }

// @JsonSerializable()
// class SellerInfo {
//   @JsonKey(name: '_id')
//   final String? id;
//   final String? firstName;
//   final String? email;

//   SellerInfo({this.id, this.firstName, this.email});

//   factory SellerInfo.fromJson(Map<String, dynamic> json) =>
//       _$SellerInfoFromJson(json);

// //       SellerInfo? sellerInfo;
// // final sellerRaw = json['sellerId'];

// // if (sellerRaw is Map<String, dynamic>) {
// //   sellerInfo = SellerInfo.fromJson(sellerRaw);
// // } else if (sellerRaw is List && sellerRaw.isNotEmpty) {
// //   final first = sellerRaw.first;
// //   if (first is Map<String, dynamic>) {
// //     sellerInfo = SellerInfo.fromJson(first);
// //   } else {
// //     print('⚠️ Unexpected item in sellerId list: $first');
// //   }
// // } else if (sellerRaw is String) {
// //   print('ℹ️ sellerId is a plain String ID: $sellerRaw');
// //   sellerInfo = SellerInfo(id: sellerRaw, firstName: '', email: '');
// // } else if (sellerRaw == null) {
// //   print('ℹ️ sellerId is null');
// // } else {
// //   print('❗ Unexpected sellerId type: ${sellerRaw.runtimeType}');
// // }

//   Map<String, dynamic> toJson() => _$SellerInfoToJson(this);
// }
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson_api_model.g.dart';

@JsonSerializable()
class LessonModel {
  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  final String? description;
  final String? authorName;
  final String? duration;
  final double? price;

  @JsonKey(name: 'courseId')
  final CourseInfo? courseInfo;

  @JsonKey(name: 'sellerId')
  final SellerInfo? sellerInfo;

  final String? imagepath;
  final String? filepath;
  final String? createdAt;
  final String? updatedAt;

  LessonModel({
    this.id,
    this.name,
    this.description,
    this.authorName,
    this.duration,
    this.price,
    this.courseInfo,
    this.sellerInfo,
    this.imagepath,
    this.filepath,
    this.createdAt,
    this.updatedAt,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    // Parse courseId
    CourseInfo? courseInfo;
    final courseRaw = json['courseId'];
    if (courseRaw is Map<String, dynamic>) {
      courseInfo = CourseInfo.fromJson(courseRaw);
    } else if (courseRaw is List && courseRaw.isNotEmpty) {
      final first = courseRaw.first;
      if (first is Map<String, dynamic>) {
        courseInfo = CourseInfo.fromJson(first);
      } else {
        print('⚠️ Unexpected item in courseId list: $first');
      }
    } else if (courseRaw is String) {
      print('ℹ️ courseId is a plain String ID: $courseRaw');
      courseInfo = CourseInfo(id: courseRaw, name: '');
    } else if (courseRaw == null) {
      print('ℹ️ courseId is null');
    } else {
      print('❗ Unexpected courseId type: ${courseRaw.runtimeType}');
    }

    // Parse sellerId
    SellerInfo? sellerInfo;
    final sellerRaw = json['sellerId'];
    if (sellerRaw is Map<String, dynamic>) {
      sellerInfo = SellerInfo.fromJson(sellerRaw);
    } else if (sellerRaw is List && sellerRaw.isNotEmpty) {
      final first = sellerRaw.first;
      if (first is Map<String, dynamic>) {
        sellerInfo = SellerInfo.fromJson(first);
      } else {
        print('⚠️ Unexpected item in sellerId list: $first');
      }
    } else if (sellerRaw is String) {
      print('ℹ️ sellerId is a plain String ID: $sellerRaw');
      sellerInfo = SellerInfo(id: sellerRaw, firstName: '', email: '');
    } else if (sellerRaw == null) {
      print('ℹ️ sellerId is null');
    } else {
      print('❗ Unexpected sellerId type: ${sellerRaw.runtimeType}');
    }

    return LessonModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      authorName: json['authorName'] as String?,
      duration: json['duration'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      courseInfo: courseInfo,
      sellerInfo: sellerInfo,
      imagepath: json['imagepath'] as String?,
      filepath: json['filepath'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() => _$LessonModelToJson(this);

  LessonEntity toEntity() {
    return LessonEntity(
      id: id ?? '',
      name: name ?? '',
      description: description ?? '',
      authorName: authorName ?? '',
      duration: duration ?? '',
      price: price ?? 0.0,
      courseId: courseInfo?.id,
      courseName: courseInfo?.name,
      sellerId: sellerInfo?.id,
      sellerName: sellerInfo?.firstName,
      sellerEmail: sellerInfo?.email,
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

@JsonSerializable()
class CourseInfo {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;

  CourseInfo({this.id, this.name});

  factory CourseInfo.fromJson(Map<String, dynamic> json) =>
      _$CourseInfoFromJson(json);

  Map<String, dynamic> toJson() => _$CourseInfoToJson(this);
}

@JsonSerializable()
class SellerInfo {
  @JsonKey(name: '_id')
  final String? id;
  final String? firstName;
  final String? email;

  SellerInfo({this.id, this.firstName, this.email});

  factory SellerInfo.fromJson(Map<String, dynamic> json) =>
      _$SellerInfoFromJson(json);

  Map<String, dynamic> toJson() => _$SellerInfoToJson(this);
}
