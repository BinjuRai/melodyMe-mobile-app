import 'package:batch34_b/features/lesson/data/data_source/lesson_data_source.dart';

import 'package:batch34_b/features/lesson/data/repository/lesson_repository_impl.dart';
import 'package:batch34_b/features/lesson/domain/repository/lesson_repository.dart';
import 'package:batch34_b/features/lesson/domain/usecase/get_all_lesson_usecase.dart';
import 'package:batch34_b/features/lesson/presentation/view_model/lesson_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:batch34_b/core/network/api_service.dart';
import 'package:batch34_b/core/network/hive_service.dart';
import 'package:batch34_b/app/share_pref/token_shared_pref.dart';

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
import 'package:batch34_b/features/splash/presentation/view_model/splashscreen_view_model.dart';

import 'package:batch34_b/features/course/data/data_source/remote_datasource/course_remote_datasource.dart';
import 'package:batch34_b/features/course/data/repository/course_repository_impl.dart';
import 'package:batch34_b/features/course/domain/repository/course_repository.dart';
import 'package:batch34_b/features/course/domain/usecase/get_all_courses.dart';
import 'package:batch34_b/features/course/presentation/view_model/course_view_model.dart';

import 'package:batch34_b/features/lesson/data/data_source/lesson_data_source.dart'
    as lesson_ds;
import 'package:batch34_b/features/lesson/data/data_source/remote_datasource/lesson_remote_datasource.dart'
    as remote_ds;

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPrefs();
  await _initAuthModule();
  await _initHomeModule();
  await _initSplashModule();
  await _initCourseModule();
  await _initLessonModule();
}

Future<void> _initHiveService() async {
  serviceLocator.registerLazySingleton<HiveService>(() => HiveService());
}

Future<void> _initApiService() async {
  serviceLocator.registerLazySingleton<Dio>(() => Dio());
  serviceLocator.registerLazySingleton<ApiService>(
    () => ApiService(serviceLocator<Dio>()),
  );
}

Future<void> _initSharedPrefs() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  serviceLocator.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(
      sharedPreferences: serviceLocator<SharedPreferences>(),
    ),
  );
}

Future<void> _initAuthModule() async {
  // Data Sources
  serviceLocator.registerFactory<UserLocalDatasource>(
    () => UserLocalDatasource(hiveService: serviceLocator<HiveService>()),
  );
  serviceLocator.registerFactory<UserRemoteDatasource>(
    () => UserRemoteDatasource(apiService: serviceLocator<ApiService>()),
  );

  // Repositories
  serviceLocator.registerFactory<UserLocalRepository>(
    () => UserLocalRepository(
      userLocalDatasource: serviceLocator<UserLocalDatasource>(),
    ),
  );
  serviceLocator.registerFactory<UserRemoteRepository>(
    () => UserRemoteRepository(
      userRemoteDataSource: serviceLocator<UserRemoteDatasource>(),
    ),
  );

  // Use Cases
  serviceLocator.registerFactory<UserLoginUsecase>(
    () => UserLoginUsecase(
      userRepository: serviceLocator<UserRemoteRepository>(),
      tokenSharedPrefs: serviceLocator<TokenSharedPrefs>(),
    ),
  );
  serviceLocator.registerFactory<UserRegisterUsecase>(
    () => UserRegisterUsecase(
      userRepository: serviceLocator<UserRemoteRepository>(),
    ),
  );
  serviceLocator.registerFactory<UploadImageUsecase>(
    () => UploadImageUsecase(
      userRepository: serviceLocator<UserRemoteRepository>(),
    ),
  );
  serviceLocator.registerFactory<UserGetCurrentUsecase>(
    () => UserGetCurrentUsecase(
      userRepository: serviceLocator<UserRemoteRepository>(),
    ),
  );

  // ViewModels
  serviceLocator.registerFactory<RegisterViewModel>(
    () => RegisterViewModel(
      serviceLocator<UserRegisterUsecase>(),
      serviceLocator<UploadImageUsecase>(),
    ),
  );
  serviceLocator.registerFactory<LoginViewModel>(
    () => LoginViewModel(serviceLocator<UserLoginUsecase>()),
  );
}

Future<void> _initHomeModule() async {
  serviceLocator.registerFactory<HomeViewModel>(
    () => HomeViewModel(loginViewModel: serviceLocator<LoginViewModel>()),
  );
}

Future<void> _initSplashModule() async {
  serviceLocator.registerFactory<SplashscreenViewModel>(
    () => SplashscreenViewModel(),
  );
}

Future<void> _initCourseModule() async {
  serviceLocator.registerFactory<CourseRemoteDataSource>(
    () => CourseRemoteDataSourceImpl(
      apiService: serviceLocator<ApiService>(), // ✅ Only ApiService now
    ),
  );

  serviceLocator.registerFactory<CourseRepository>(
    () => CourseRepositoryImpl(
      remoteDataSource: serviceLocator<CourseRemoteDataSource>(),
    ),
  );

  serviceLocator.registerFactory<GetAllCourses>(
    () => GetAllCourses(serviceLocator<CourseRepository>()),
  );

  serviceLocator.registerFactory<CourseBloc>(
    () => CourseBloc(getAllCourses: serviceLocator<GetAllCourses>()),
  );
}

Future<void> _initLessonModule() async {
  serviceLocator.registerFactory<LessonRemoteDataSource>(
    () => LessonRemoteDataSourceImpl(dio: serviceLocator<Dio>()),
  );

  serviceLocator.registerFactory<LessonRepository>(
    () => LessonRepositoryImpl(
      remoteDataSource: serviceLocator<LessonRemoteDataSource>(),
    ),
  );

  // serviceLocator.registerFactory<GetAllLessonsUseCase>(
  //   () => GetAllLessonsUseCase(: serviceLocator<LessonRepository>()),
  // );
  serviceLocator.registerFactory<GetAllLessonsUseCase>(
    () => GetAllLessonsUseCase(serviceLocator<LessonRepository>()),
  );

  serviceLocator.registerFactory<LessonBloc>(
    () => LessonBloc(
      getAllLessonsUseCase: serviceLocator<GetAllLessonsUseCase>(),
      lessonRepository: serviceLocator<LessonRepository>(),
    ),
  );
}


// Future<void> _initLessonModule() async {
//  serviceLocator.registerFactory<LessonRemoteDataSource>(
//   () => LessonRemoteDataSourceImpl(dio: serviceLocator<Dio>()),
// );

// serviceLocator.registerFactory<LessonRepository>(
//   () => LessonRepositoryImpl(serviceLocator<LessonRemoteDataSource>()),
// );

// serviceLocator.registerFactory<GetAllLessonsUseCase>(
//   () => GetAllLessonsUseCase(serviceLocator<LessonRepository>()),
// );

// serviceLocator.registerFactory<LessonBloc>(
//   () => LessonBloc(
//     getAllLessonsUseCase: serviceLocator<GetAllLessonsUseCase>(),
//     lessonRepository: serviceLocator<LessonRepository>(),
//   ),
// );

// }



  // serviceLocator.registerFactory<LessonBloc>(
  //   () => LessonBloc(getAllLessonsUseCase: serviceLocator<>()),
  // );

