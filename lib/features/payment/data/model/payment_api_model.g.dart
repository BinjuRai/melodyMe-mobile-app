// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) => PaymentModel(
      id: json['_id'] as String,
      pricePaid: (json['pricePaid'] as num).toDouble(),
      paymentMethod: json['paymentMethod'] as String,
      paymentStatus: json['paymentStatus'] as String,
      paymentDate: json['paymentDate'] as String,
      userInfo: UserInfo.fromJson(json['userId'] as Map<String, dynamic>),
      courseInfo: CourseInfo.fromJson(json['courseId'] as Map<String, dynamic>),
      lessonInfo: json['lessonId'] == null
          ? null
          : LessonInfo.fromJson(json['lessonId'] as Map<String, dynamic>),
      type: json['type'] as String?,
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'pricePaid': instance.pricePaid,
      'paymentMethod': instance.paymentMethod,
      'paymentStatus': instance.paymentStatus,
      'paymentDate': instance.paymentDate,
      'userId': instance.userInfo,
      'courseId': instance.courseInfo,
      'lessonId': instance.lessonInfo,
      'type': instance.type,
    };
