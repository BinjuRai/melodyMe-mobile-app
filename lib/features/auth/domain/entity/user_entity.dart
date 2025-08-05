import 'package:equatable/equatable.dart';
// import 'package:student_management/features/batch/domain/entity/batch_entity.dart';
// import 'package:student_management/features/course/domain/entity/course_entity.dart';

class UserEntity extends Equatable {
  final String? userId;
  final String username;
  final String phoneno;
  final String email;
  final String password;
  final String? image;

  const UserEntity({
    this.userId,
    this.image,
    required this.phoneno,
    required this.email,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props => [userId, username, phoneno, email, password];
}
