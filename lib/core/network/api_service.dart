// import 'package:batch34_b/app/constant/api_endpoints.dart';
// import 'package:batch34_b/core/network/dio_error_interceptor.dart';
// import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

// class ApiService {
//   final Dio _dio;

//   Dio get dio => _dio;

//   ApiService(this._dio) {
//     _dio
//       ..options.baseUrl = ApiEndpoints.baseUrl
//       ..options.connectTimeout = ApiEndpoints.connectionTimeout
//       ..options.receiveTimeout = ApiEndpoints.receiveTimeout
//       ..interceptors.add(DioErrorInterceptor())
//       ..interceptors.add(
//         PrettyDioLogger(
//           requestHeader: true,
//           requestBody: true,
//           responseHeader: true,
//         ),
//       )
//       ..options.headers = {
//         'Accept': 'application/json',
//         'Content-Type': 'application/json',
//       };
//   }
// }

import 'package:batch34_b/app/constant/api_endpoints.dart';
import 'package:batch34_b/core/network/dio_error_interceptor.dart';
import 'package:batch34_b/features/auth/data/repository/file_upload_repository_impl.dart';
import 'package:batch34_b/features/auth/domain/use_case/upload_file_usecase.dart';
import 'package:batch34_b/features/auth/presentation/view/upload_cubit.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  final Dio _dio;

  late final FileUploadRepositoryImpl fileUploadRepository;
  late final UploadFileUseCase uploadFileUseCase;
  late final UploadCubit uploadCubit;

  Dio get dio => _dio;

  ApiService(this._dio) {
    _dio
      ..options.baseUrl = ApiEndpoints.baseUrl
      ..options.connectTimeout = ApiEndpoints.connectionTimeout
      ..options.receiveTimeout = ApiEndpoints.receiveTimeout
      ..interceptors.add(DioErrorInterceptor())
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      )
      ..options.headers = {
        'Accept': 'application/json',
        // No forced Content-Type for multipart
      };

    fileUploadRepository = FileUploadRepositoryImpl(_dio);
    uploadFileUseCase = UploadFileUseCase(fileUploadRepository);
    uploadCubit = UploadCubit(uploadFileUseCase);
  }
}

// class ApiService {
//   final Dio _dio;

//   Dio get dio => _dio;
//   final dio = Dio(BaseOptions(baseUrl: ApiEndpoints.serverAddress));

// final fileUploadRepository = FileUploadRepositoryImpl(dio);
// final uploadFileUseCase = UploadFileUseCase(fileUploadRepository);
// final uploadCubit = UploadCubit(uploadFileUseCase);

//   ApiService(this._dio) {
//     _dio
//       ..options.baseUrl = ApiEndpoints.baseUrl
//       ..options.connectTimeout = ApiEndpoints.connectionTimeout
//       ..options.receiveTimeout = ApiEndpoints.receiveTimeout
//       ..interceptors.add(DioErrorInterceptor())
//       ..interceptors.add(
//         PrettyDioLogger(
//           requestHeader: true,
//           requestBody: true,
//           responseHeader: true,
//         ),
//       )
//       ..options.headers = {
//         'Accept': 'application/json',
//         // ✅ Do not force Content-Type here
//         // 'Content-Type': 'application/json', // ❌ REMOVE THIS
//       };
//   }
// }
