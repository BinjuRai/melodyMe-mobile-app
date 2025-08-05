// import 'package:batch34_b/features/payment/data/model/course_info_model.dart';
// import 'package:batch34_b/features/payment/data/model/lesson_info_model.dart';
// import 'package:batch34_b/features/payment/data/model/user_info_model.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:batch34_b/features/payment/domain/entity/payment_entity.dart';

// part 'payment_api_model.g.dart';

// @JsonSerializable()
// class PaymentModel {
//   @JsonKey(name: '_id')
//   final String id;

//   final double pricePaid;
//   final String paymentMethod;
//   final String paymentStatus;
//   final String paymentDate;

//   @JsonKey(name: 'userId')
//   final UserInfo userInfo;

//   @JsonKey(name: 'courseId')
//   final CourseInfo courseInfo;

//   @JsonKey(name: 'lessonId')
//   final LessonInfo? lessonInfo;
//   final String? type;

//   PaymentModel({
//     required this.id,
//     required this.pricePaid,
//     required this.paymentMethod,
//     required this.paymentStatus,
//     required this.paymentDate,
//     required this.userInfo,
//     required this.courseInfo,
//     this.lessonInfo,
//     this.type,
//   });

//   factory PaymentModel.fromJson(Map<String, dynamic> json) =>
//       _$PaymentModelFromJson(json);

//   Map<String, dynamic> toJson() => _$PaymentModelToJson(this);

//   PaymentEntity toEntity() {
//     return PaymentEntity(
//       id: id,
//       userId: userInfo.id,
//       username: userInfo.username,
//       courseId: courseInfo.id,
//       courseTitle: courseInfo.title,
//       lessonId: lessonInfo?.id,
//       lessonTitle: lessonInfo?.title,
//       pricePaid: pricePaid,
//       paymentMethod: paymentMethod,
//       paymentStatus: paymentStatus,
//       paymentDate: DateTime.parse(paymentDate),
//       type: type ?? 'lesson',
//     );
//   }

//   Map<String, dynamic> toRequestJson() {
//     return {
//       '_id': id,
//       'pricePaid': pricePaid,
//       'paymentMethod': paymentMethod,
//       'paymentStatus': paymentStatus,
//       'paymentDate': paymentDate,
//       'userId': userInfo.id, // only send user ID string
//       'courseId': courseInfo.id, // only send course ID string
//       'lessonId': lessonInfo?.id,
//       'type': type, // include type if available
//       // only send lesson ID string or null
//     };
//   }
// }
import 'package:json_annotation/json_annotation.dart';
import 'package:batch34_b/features/payment/domain/entity/payment_entity.dart';

part 'payment_api_model.g.dart';

@JsonSerializable()
class PaymentModel {
  @JsonKey(name: '_id')
  final String id;

  final double pricePaid;
  final String paymentMethod;
  final String paymentStatus;
  final String paymentDate;

  final String? userId; // flat string from API
  final String? username; // flat string from API
  final String? courseId; // flat string from API
  final String? lessonId; // flat string from API
  final String? type;

  PaymentModel({
    required this.id,
    required this.pricePaid,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.paymentDate,
    this.userId,
    this.username,
    this.courseId,
    this.lessonId,
    this.type,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentModelToJson(this);

  PaymentEntity toEntity() {
    return PaymentEntity(
      id: id,
      userId: userId,
      username: username,
      courseId: courseId,
      lessonId: lessonId,
      lessonTitle: null,
      pricePaid: pricePaid,
      paymentMethod: paymentMethod,
      paymentStatus: paymentStatus,
      paymentDate: DateTime.parse(paymentDate),
      type: type ?? 'lesson',
    );
  }

  Map<String, dynamic> toRequestJson() {
    return {
      '_id': id,
      'pricePaid': pricePaid,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'paymentDate': paymentDate,
      'userId': userId,
      'courseId': courseId,
      'lessonId': lessonId,
      'type': type,
    };
  }
}
