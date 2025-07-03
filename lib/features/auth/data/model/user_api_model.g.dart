// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      userId: json['_id'] as String?,
      username: json['username'] as String,
      phoneno: json['phoneno'] as String,
      email: json['email'] as String,
      password: json['password'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$UserApiModelToJson(UserApiModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'username': instance.username,
      'phoneno': instance.phoneno,
      'email': instance.email,
      'password': instance.password,
      'image': instance.image,
    };
