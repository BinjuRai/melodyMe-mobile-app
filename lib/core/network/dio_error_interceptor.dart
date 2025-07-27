// import 'package:dio/dio.dart';

// class DioErrorInterceptor extends Interceptor {
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     String errorMessage;

//     if (err.response != null) {
//       final statusCode = err.response?.statusCode ?? 0;
//       if (statusCode >= 300) {
//         errorMessage =
//             err.response?.data['message']?.toString() ??
//             err.response?.statusMessage ??
//             'Unknown error';
//       } else {
//         errorMessage = 'Something went wrong';
//       }
//     } else {
//       errorMessage = 'Connection error';
//     }

//     final customError = DioException(
//       requestOptions: err.requestOptions,
//       response: err.response,
//       error: errorMessage,
//       type: err.type,
//     );

//     super.onError(customError, handler);
//   }
// }

import 'package:dio/dio.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    String errorMessage;

    if (err.response != null) {
      final statusCode = err.response?.statusCode ?? 0;

      if (statusCode >= 400 && statusCode < 500) {
        // Handle client errors (4xx)
        errorMessage = err.response?.data['message']?.toString() ?? 
                       err.response?.statusMessage ?? 
                       'Client error occurred. Please check your input.';
      } else if (statusCode >= 500) {
        // Handle server errors (5xx)
        errorMessage = err.response?.data['message']?.toString() ?? 
                       err.response?.statusMessage ?? 
                       'Server is down. Please try again later.';
      } else {
        // Any other errors
        errorMessage = 'Something went wrong';
      }
    } else {
      // Network-related errors (timeouts, no connection, etc.)
      if (err.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timeout. Please try again later.';
      } else if (err.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Server did not respond in time. Please try again later.';
      } else if (err.type == DioExceptionType.cancel) {
        errorMessage = 'Request was canceled.';
      // } else if (err.type == DioExceptionType.other) {
      //   errorMessage = 'Network error. Please check your internet connection.';
      } else {
        errorMessage = 'Unknown error occurred.';
      }
    }

    // Logging the error can help with debugging in development
    print('Dio Error: $errorMessage');
    
    final customError = DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      error: errorMessage,
      type: err.type,
    );

    super.onError(customError, handler);
  }
}

