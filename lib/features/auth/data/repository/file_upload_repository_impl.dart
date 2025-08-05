// data/repositories/file_upload_repository_impl.dart
import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/auth/domain/repository/file_upload_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';



class FileUploadRepositoryImpl implements FileUploadRepository {
  final Dio dio;

  FileUploadRepositoryImpl(this.dio);

  @override
  Future<Either<Failure, String>> uploadFile(String path, String name, String type) async {
    try {
      final multipartFile = await MultipartFile.fromFile(path, filename: name);
      final formData = FormData.fromMap({
        'file': multipartFile, // your multer expects 'file' field
      });

      final response = await dio.post(
        '/api/upload', // your upload endpoint
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
        ),
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        return Right(response.data['data']['filename']);
      } else {
        return Left(ServerFailure(message: response.data['message'] ?? 'Upload failed'));
      }
    } on DioError catch (e) {
      return Left(ServerFailure(message: e.message ?? 'Network error'));
    }
  }
}
