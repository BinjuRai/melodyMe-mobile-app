

import 'package:batch34_b/app/constant/hive_table_constant.dart';
import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:uuid/uuid.dart';

// dart run build_runner build -d
part 'user_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.userTableId)
class UserHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String phoneno;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String password;
  @HiveField(5)
  final String? image;

  UserHiveModel({
    String? userId,
    required this.username,
    this.image,
    required this.phoneno,
    // required this.batch,
    // required this.courses,
    required this.email,
    required this.password,
  }) : userId= userId?? const Uuid().v4();

  // Initial Constructor
  const UserHiveModel.initial()
    : userId='',
    image = '',
      username = '',
      phoneno = '',
      email = '',
      password = '';

  // From Entity
  factory UserHiveModel.fromEntity(UserEntity entity) {
    return UserHiveModel(
      userId: entity.userId,
      image: entity.image,
      username: entity.username,
      phoneno: entity.phoneno,
      email: entity.email,
      password: entity.password,
    );
  }

  // To Entity
  UserEntity toEntity() {
    return UserEntity(
      userId:userId,
      image: image,
      username: username,
      phoneno: phoneno,
      email: email,
      password: password,
    );
  }

  @override
  List<Object?> get props => [ userId,image,  phoneno, username, email, password];
}
