// import 'dart:io';

// import 'package:batch34_b/core/network/hive_service.dart';
// import 'package:batch34_b/features/auth/data/data_source/user_data_source.dart';
// import 'package:batch34_b/features/auth/data/model/user_hive_model.dart';
// import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';

// class UserLocalDatasource implements IUserDatasource {
//   final HiveService _hiveService;

//   UserLocalDatasource({required HiveService hiveService})
//     : _hiveService = hiveService;

//   @override
//   Future<String> loginUser(String username, String password) async {
//     try {
//       final userData = await _hiveService.login(username, password);
//       if (userData != null && userData.password == password) {
//         return "Login successful";
//       } else {
//         throw Exception("Invalid username or password");
//       }
//     } catch (e) {
//       throw Exception("Login failed: $e");
//     }
//   }

//   @override
//   Future<void> registerUser(UserEntity user) async {
//     try {
//       // Convert UserEntity to Hive model if necessary
//       final userHiveModel = UserHiveModel.fromEntity(user);
//       await _hiveService.register(userHiveModel);
//     } catch (e) {
//       throw Exception("Registration failed: $e");
//     }
//   }

//   @override
//   Future<UserEntity> getCurrentUser() async {
//     // TODO: implement uploadProfilePicture
//     throw UnimplementedError();
//   }

//   @override
//   Future<String> uploadProfilePicture(File file) {
//     // TODO: implement uploadProfilePicture
//     throw UnimplementedError();
//   }
// }

import 'dart:io';

import 'package:batch34_b/core/network/hive_service.dart';
import 'package:batch34_b/features/auth/data/data_source/user_data_source.dart';
import 'package:batch34_b/features/auth/data/model/user_hive_model.dart';
import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';

class UserLocalDatasource implements IUserDatasource {
  final HiveService _hiveService;

  UserLocalDatasource({required HiveService hiveService})
    : _hiveService = hiveService;

  @override
  Future<void> registerUser(UserEntity user) async {
    try {
      final userHiveModel = UserHiveModel.fromEntity(user);
      await _hiveService.register(userHiveModel);
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }

  @override
  Future<String> loginUser(String username, String password) async {
    try {
      final userData = await _hiveService.login(username, password);
      if (userData != null && userData.password == password) {
        return "Login successful";
      } else {
        throw Exception("Invalid username or password");
      }
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  @override
  Future<UserEntity> getCurrentUser() async {
    try {
      final userData = await _hiveService.getCurrentUser();
      if (userData != null) {
        return userData.toEntity();
      } else {
        throw Exception("No user found");
      }
    } catch (e) {
      throw Exception("Failed to get current user: $e");
    }
  }

  @override
  Future<UserEntity> getProfile() async {
    try {
      final userData = await _hiveService.getCurrentUser();
      if (userData != null) {
        return userData.toEntity();
      } else {
        throw Exception("Profile not found");
      }
    } catch (e) {
      throw Exception("Failed to get profile: $e");
    }
  }

  // @override
  // Future<UserEntity> updateProfile(Map<String, dynamic> updates) async {
  //   try {
  //     final updatedUser = await _hiveService.updateProfile(updates);
  //     if (updatedUser != null) {
  //       return updatedUser.toEntity();
  //     } else {
  //       throw Exception("Failed to update user");
  //     }
  //   } catch (e) {
  //     throw Exception("Update failed: $e");
  //   }
  // }

  // @override
  // Future<void> changePassword(String oldPassword, String newPassword) async {
  //   try {
  //     await _hiveService.changePassword(oldPassword, newPassword);
  //   } catch (e) {
  //     throw Exception("Password change failed: $e");
  //   }
  // }

  @override
  Future<String> uploadProfilePicture(File file) {
    throw UnimplementedError(
      "Profile picture upload is not supported locally.",
    );
  }
}
