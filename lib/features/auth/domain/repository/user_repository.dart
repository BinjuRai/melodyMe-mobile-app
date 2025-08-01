
import 'dart:io';

import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class IUserRepository {
  Future<Either<Failure, void>> registerUser(UserEntity user);

  Future<Either<Failure, String>> loginUser(String email, String password);

  Future<Either<Failure, String>> uploadProfilePicture(File file);

  Future<Either<Failure, UserEntity>> getCurrentUser();

  /// Gets user profile details
  Future<Either<Failure, UserEntity>> getProfile();

  /// Updates user profile with given fields
  Future<Either<Failure, UserEntity>> updateProfile(Map<String, dynamic> updates);

  /// Changes user's password
  Future<Either<Failure, void>> changePassword(String oldPassword, String newPassword);
}
