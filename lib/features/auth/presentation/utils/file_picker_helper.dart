// presentation/utils/file_picker_helper.dart
import 'package:file_picker/file_picker.dart';

class FilePickerHelper {
  /// Pick a file with optional allowed extensions
  static Future<PlatformFile?> pickFile({List<String>? allowedExtensions}) async {
    final result = await FilePicker.platform.pickFiles(
      type: allowedExtensions != null ? FileType.custom : FileType.any,
      allowedExtensions: allowedExtensions,
    );

    if (result == null || result.files.isEmpty) return null;

    return result.files.single;
  }
}
