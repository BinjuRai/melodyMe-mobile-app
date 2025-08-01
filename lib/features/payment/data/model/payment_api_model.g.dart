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
      userId: json['userId'] as String?,
      username: json['username'] as String?,
      courseId: json['courseId'] as String?,
      lessonId: json['lessonId'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$PaymentModelToJson(PaymentModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'pricePaid': instance.pricePaid,
      'paymentMethod': instance.paymentMethod,
      'paymentStatus': instance.paymentStatus,
      'paymentDate': instance.paymentDate,
      'userId': instance.userId,
      'username': instance.username,
      'courseId': instance.courseId,
      'lessonId': instance.lessonId,
      'type': instance.type,
    };
