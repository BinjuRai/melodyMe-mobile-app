import 'dart:io';
import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';

abstract interface class IUserDatasource {
  Future<void> registerUser(UserEntity userData);

  Future<String> loginUser(String email, String password);

  Future<String> uploadProfilePicture(File file);

  Future<UserEntity> getCurrentUser();

  Future<UserEntity> getProfile();

  // Future<UserEntity> updateProfile(Map<String, dynamic> updates);
  // Future<void> changePassword(String oldPassword, String newPassword);
}
