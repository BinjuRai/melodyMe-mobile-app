// presentation/cubit/upload_cubit.dart

import 'package:batch34_b/features/auth/domain/use_case/upload_file_usecase.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/file_picker_helper.dart';

class UploadCubit extends Cubit<String?> {
  final UploadFileUseCase uploadFileUseCase;

  UploadCubit(this.uploadFileUseCase) : super(null);

  Future<void> pickAndUploadFile() async {
    final file = await FilePickerHelper.pickFile(
      allowedExtensions: ['jpg', 'png', 'pdf', 'mp4'], // allowed types
    );

    if (file == null) {
      emit(null); // or emit some error state
      return;
    }

    final result = await uploadFileUseCase(
      filePath: file.path!,
      fileName: file.name,
      fileType: file.extension ?? '',
    );

    result.fold(
      (failure) => emit(null), // handle error with another state maybe
      (uploadedFileName) => emit(uploadedFileName),
    );
  }
}
