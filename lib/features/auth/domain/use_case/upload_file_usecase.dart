// domain/usecases/upload_file_usecase.dart
import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/auth/domain/repository/file_upload_repository.dart';
import 'package:dartz/dartz.dart';


class UploadFileUseCase {
  final FileUploadRepository repository;

  UploadFileUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required String filePath,
    required String fileName,
    required String fileType, // optional: image/video/pdf/audio
  }) {
    return repository.uploadFile(filePath, fileName, fileType);
  }
}
