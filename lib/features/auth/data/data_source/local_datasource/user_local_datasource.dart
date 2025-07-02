import 'dart:io';

import 'package:batch34_b/core/network/hive_service.dart';
import 'package:batch34_b/features/auth/data/data_source/user_data_source.dart';
import 'package:batch34_b/features/auth/data/model/user_hive_model.dart';
import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';


class UserLocalDatasource implements IUserDatasource{
  final HiveService _hiveService;

  UserLocalDatasource({required HiveService hiveService})
    : _hiveService = hiveService;

  @override
  Future<String> loginUser(String username, String password) async {
    try {
      final studentData = await _hiveService.login(username, password);
      if (studentData != null && studentData.password == password) {
        return "Login successful";
      } else {
        throw Exception("Invalid username or password");
      }
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  @override
  Future<void> registerUser(UserEntity student) async {
    try {
      // Convert UserEntity to Hive model if necessary
      final studentHiveModel = UserHiveModel.fromEntity(student);
      await _hiveService.register(studentHiveModel);
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }

  @override
  Future<UserEntity> getCurrentUser() async {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
  
  
}
