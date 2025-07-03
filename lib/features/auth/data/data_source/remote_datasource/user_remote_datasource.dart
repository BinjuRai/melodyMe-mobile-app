import 'dart:io';
import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/core/network/api_service.dart';
import 'package:batch34_b/features/auth/data/data_source/user_data_source.dart';
import 'package:batch34_b/features/auth/data/model/user_api_model.dart';

import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';
import 'package:dio/dio.dart';

class UserRemoteDatasource implements IUserDatasource {
  final ApiService _apiService;
  UserRemoteDatasource({required ApiService apiService})
    : _apiService = apiService;

  @override
  Future<UserEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      final response = await _apiService.dio.post(
        ApiEndpoints.login,
        data: {'email': email, 'password': password},
      );
      if (response.statusCode == 200) {
        final str = response.data['token'];
        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to login User: ${e.message}');
    } catch (e) {
      throw Exception('Failed to login User: $e');
    }
  }

  @override
  Future<void> registerUser(UserEntity userData) async {
      try {
      final userApiModel = UserApiModel.fromEntity(userData);
      final response = await _apiService.dio.post(
        ApiEndpoints.register,
        data: userApiModel.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        throw Exception(
          'Failed to register User: ${response.statusMessage}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Failed to register User: ${e.message}');
    } catch (e) {
      throw Exception('Failed to register User: $e');
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
   try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        'profilePicture': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      Response response = await _apiService.dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Extract the image name from the response
        final str = response.data['data'];
        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to upload profile picture: ${e.message}');
    } catch (e) {
      throw Exception('Failed to upload profile picture: $e');
    }
  }
}

// class UserRemoteDataSource implements IUserDataSource {
//   final ApiService _apiService;
//   UserRemoteDataSource({required ApiService apiService})
//     : _apiService = apiService;

//   @override
//   Future<String> loginUser(String username, String password) async {
//     try {
//       final response = await _apiService.dio.post(
//         ApiEndpoints.login,
//         data: {'email': email, 'password': password},
//       );
//       if (response.statusCode == 200) {
//         final str = response.data['token'];
//         return str;
//       } else {
//         throw Exception(response.statusMessage);
//       }
//     } on DioException catch (e) {
//       throw Exception('Failed to login User: ${e.message}');
//     } catch (e) {
//       throw Exception('Failed to login User: $e');
//     }
//   }

//   @override
//   Future<void> registerUser(UserEntity userData) async {
//     try {
//       final UserApiModel = UserApiModel.fromEntity(userData);
//       final response = await _apiService.dio.post(
//         ApiEndpoints.register,
//         data: UserApiModel.toJson(),
//       );
//       if (response.statusCode == 200) {
//         return;
//       } else {
//         throw Exception(
//           'Failed to register User: ${response.statusMessage}',
//         );
//       }
//     } on DioException catch (e) {
//       throw Exception('Failed to register User: ${e.message}');
//     } catch (e) {
//       throw Exception('Failed to register User: $e');
//     }
//   }

//   @override
//   Future<String> uploadProfilePicture(File file) async {
//     try {
//       String fileName = file.path.split('/').last;
//       FormData formData = FormData.fromMap({
//         'profilePicture': await MultipartFile.fromFile(
//           file.path,
//           filename: fileName,
//         ),
//       });

//       Response response = await _apiService.dio.post(
//         ApiEndpoints.uploadImage,
//         data: formData,
//       );

//       if (response.statusCode == 200) {
//         // Extract the image name from the response
//         final str = response.data['data'];
//         return str;
//       } else {
//         throw Exception(response.statusMessage);
//       }
//     } on DioException catch (e) {
//       throw Exception('Failed to upload profile picture: ${e.message}');
//     } catch (e) {
//       throw Exception('Failed to upload profile picture: $e');
//     }
//   }

// }
