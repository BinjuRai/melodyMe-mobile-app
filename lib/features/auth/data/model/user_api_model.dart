import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_api_model.g.dart'; //  dart run build_runner build -d  to generate this

@JsonSerializable()
class UserApiModel extends Equatable {
  @JsonKey(name: '_id')
    final String? userId;
  final String username;
  final String phoneno;
  final String email;
  final String? password;
  final String? image;
  

  const UserApiModel({
    this.userId,
    required this.username,
    required this.phoneno,
    required this.email,
    required this.password,
    this.image
  });

 

  /// JSON serialization
  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserApiModelToJson(this);


  // To Entity
  UserEntity toEntity() {
    return UserEntity(
     userId: userId,
      username: username,
      phoneno: phoneno,
      image: image,
      email: email,
      password: password ?? '' ,
    );
  }

  // From Entity
  factory UserApiModel.fromEntity(UserEntity entity) {
    final user = UserApiModel(
      username: entity.username,
      password: entity.password,
      email: entity.email,
      image: entity.image,
      phoneno: entity.phoneno,
    );
    return user;
  }

  @override
  List<Object?> get props => [
        userId,
        username,
        phoneno,
        email,
        password,
        
      ];
}
