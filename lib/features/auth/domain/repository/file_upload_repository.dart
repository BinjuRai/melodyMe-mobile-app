// domain/repositories/file_upload_repository.dart
import 'package:batch34_b/core/error/failure.dart';
import 'package:dartz/dartz.dart';


abstract class FileUploadRepository {
  Future<Either<Failure, String>> uploadFile(String path, String name, String type);
}
