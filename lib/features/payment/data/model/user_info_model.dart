import 'package:json_annotation/json_annotation.dart';

part 'user_info_model.g.dart';

@JsonSerializable()
class UserInfo {
  @JsonKey(name: '_id')
  final String id;
  final String username;
  final String email;

  UserInfo({required this.id, required this.username, required this.email});

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
