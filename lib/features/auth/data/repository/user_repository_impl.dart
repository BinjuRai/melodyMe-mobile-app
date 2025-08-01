import 'dart:io';

import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';
import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements IUserRepository {

  @override
  Future<Either<Failure, void>> changePassword(String oldPassword, String newPassword) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final user = UserEntity(
        username: 'John Doe',
        email: 'john.doe@example.com',
        phoneno: '1234567890',
        password: '',
      );
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(message: 'Failed to load profile'));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(String email, String password) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> registerUser(UserEntity user) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile(Map<String, dynamic> updates) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
