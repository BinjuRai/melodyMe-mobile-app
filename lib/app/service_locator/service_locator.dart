import 'package:batch34_b/features/splash/presentation/view_model/splashscreen_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:batch34_b/features/splash/presentation/view_model/splash_view_model.dart';
import 'package:batch34_b/app/share_pref/token_shared_pref.dart';
// import 'package:batch34_b/bottom_screen/dashboard.dart';
import 'package:batch34_b/core/network/api_service.dart';
import 'package:batch34_b/core/network/hive_service.dart';
import 'package:batch34_b/features/auth/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:batch34_b/features/auth/data/data_source/remote_datasource/user_remote_datasource.dart';
import 'package:batch34_b/features/auth/data/repository/local_repository/user_local_repository.dart';
import 'package:batch34_b/features/auth/data/repository/remote_repository/user_remote_repository.dart';
import 'package:batch34_b/features/auth/domain/use_case/user_get_current_usecase.dart';
import 'package:batch34_b/features/auth/domain/use_case/user_image_upload_usecase.dart';
import 'package:batch34_b/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:batch34_b/features/auth/domain/use_case/user_register_usecase.dart';
import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:batch34_b/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:batch34_b/features/home/presentation/view_model/home_view_model.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPrefs();
  await _initAuthModule();
  await _initHomeModule();
  await _initSplashModule();
}

Future<void> _initApiService() async {
  serviceLocator.registerLazySingleton(() => ApiService(Dio()));
}

Future<void> _initHiveService() async {
  serviceLocator.registerLazySingleton(() => HiveService());
}

Future<void> _initSharedPrefs() async {
  // Initialize Shared Preferences if needed
  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPrefs);
  serviceLocator.registerLazySingleton(
    () => TokenSharedPrefs(
      sharedPreferences: serviceLocator<SharedPreferences>(),
    ),
  );
}

Future<void> _initAuthModule() async {
  // Data Source
  serviceLocator.registerFactory(
    () => UserLocalDatasource(hiveService: serviceLocator<HiveService>()),
  );

  serviceLocator.registerFactory(
    () => UserRemoteDatasource(apiService: serviceLocator<ApiService>()),
  );

  // Repository

  serviceLocator.registerFactory(
    () => UserLocalRepository(
      userLocalDatasource: serviceLocator<UserLocalDatasource>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserRemoteRepository(
     userRemoteDataSource: serviceLocator<UserRemoteDatasource>(),
    ),
  );

  // Usecases
  serviceLocator.registerFactory(
    () => UserLoginUsecase(
      userRepository: serviceLocator<UserRemoteRepository>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserRegisterUsecase(
      userRepository: serviceLocator<UserRemoteRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UploadImageUsecase(
      userRepository: serviceLocator<UserRemoteRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserGetCurrentUsecase(
      userRepository: serviceLocator<UserRemoteRepository>(),
    ),
  );

  serviceLocator.registerFactory(
    () => RegisterViewModel(
    
      serviceLocator<UserRegisterUsecase>(),
      serviceLocator<UploadImageUsecase>(),
    ),
  );

  // Register LoginViewModel WITHOUT HomeViewModel to avoid circular dependency
  serviceLocator.registerFactory(
    () => LoginViewModel(serviceLocator<UserLoginUsecase>()),
  );
}

Future<void> _initHomeModule() async {
  serviceLocator.registerFactory(
    () => HomeViewModel(loginViewModel: serviceLocator<LoginViewModel>()),
  );
}

Future<void> _initSplashModule() async {
  serviceLocator.registerFactory(() => SplashscreenViewModel());
}
// Future<void> initDependencies() async {
//   await _initHiveService();
//   await initApiModule();
//   // Initialize all modules

//   await _initAuthModule();
//   // await _initHomeModule();
//   await _initSplashModule();
// }

// Future<void> _initHiveService() async {
//   serviceLocator.registerLazySingleton(() => HiveService());
// }

// Future<void> initApiModule() async {
//   // Dio instance
//   serviceLocator.registerLazySingleton<Dio>(() => Dio());
//   serviceLocator.registerLazySingleton(() => ApiService(serviceLocator<Dio>()));
// }

// Future<void> _initAuthModule() async {
//   // ===================== Data Source ====================
//   serviceLocator.registerFactory(
//     () => UserLocalDatasource(hiveService: serviceLocator<HiveService>()),
//   );

//   serviceLocator.registerFactory(
//     () => UserLocalRepository(
//       userLocalDatasource: serviceLocator<UserLocalDatasource>(),
//     ),
//   );

//   serviceLocator.registerFactory(
//     () =>
//         UserLoginUsecase(userRepository: serviceLocator<UserLocalRepository>()),
//   );

//   serviceLocator.registerFactory(
//     () => UserRegisterUsecase(
//       userRepository: serviceLocator<UserLocalRepository>(),
//     ),
//   );

//   serviceLocator.registerFactory(
//     () => UploadImageUsecase(
//       userRepository: serviceLocator<UserLocalRepository>(),
//     ),
//   );

//   serviceLocator.registerFactory(
//     () => UserGetCurrentUsecase(
//       userRepository: serviceLocator<UserLocalRepository>(),
//     ),
//   );

//   serviceLocator.registerFactory(
//     () => RegisterViewModel(
//       serviceLocator<UserRegisterUsecase>(),
//       serviceLocator<UploadImageUsecase>(),
//     ),
//   );

//   // Register LoginViewModel WITHOUT HomeViewModel to avoid circular dependency
//   serviceLocator.registerFactory(
//     () => LoginViewModel(serviceLocator<UserLoginUsecase>()),
//   );
// }

// // Future<void> _initHomeModule() async {
// //   serviceLocator.registerFactory(
// //     () => HomeViewModel(loginViewModel: serviceLocator<LoginViewModel>()),
// //   );
// // }

// Future<void> _initSplashModule() async {
//   serviceLocator.registerFactory(() => SplashscreenViewModel());

// }
