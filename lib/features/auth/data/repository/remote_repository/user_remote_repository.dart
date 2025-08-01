import 'dart:io';

import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/auth/data/data_source/remote_datasource/user_remote_datasource.dart';
import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';
import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRemoteRepository implements IUserRepository {
  final UserRemoteDatasource _userRemoteDataSource;

  UserRemoteRepository({required UserRemoteDatasource userRemoteDataSource})
    : _userRemoteDataSource = userRemoteDataSource;

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final user = await _userRemoteDataSource.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final token = await _userRemoteDataSource.loginUser(email, password);
      return Right(token);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(UserEntity user) async {
    try {
      await _userRemoteDataSource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageUrl = await _userRemoteDataSource.uploadProfilePicture(file);
      return Right(imageUrl);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> changePassword(String oldPassword, String newPassword) {
    // TODO: implement changePassword
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, UserEntity>> getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
  }
  
  @override
  Future<Either<Failure, UserEntity>> updateProfile(Map<String, dynamic> updates) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
