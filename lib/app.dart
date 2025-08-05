
import 'package:batch34_b/app/service_locator/service_locator.dart';
import 'package:batch34_b/core/common/sensor/proximity_theme.dart';
import 'package:batch34_b/core/common/sensor/themeviewmodel/theme_bloc.dart';
import 'package:batch34_b/core/common/sensor/themeviewmodel/theme_event.dart';
import 'package:batch34_b/core/common/sensor/themeviewmodel/theme_state.dart';
import 'package:batch34_b/features/course/domain/repository/course_repository.dart';
import 'package:batch34_b/features/course/domain/usecase/get_lesson_by_courseId.dart';
import 'package:batch34_b/features/course/presentation/view_model/course_view_model.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:batch34_b/features/lesson/presentation/view_model/lesson_view_model.dart';
import 'package:batch34_b/features/payment/presentation/view/payment_submit_form.dart';
import 'package:batch34_b/features/payment/presentation/view_model/payment_view_model.dart';
import 'package:batch34_b/features/splash/presentation/view/splashscreen_view.dart';
import 'package:batch34_b/features/splash/presentation/view_model/splashscreen_view_model.dart';
import 'package:batch34_b/features/wishlist/presentation/view_model/wishlist_event.dart';
import 'package:batch34_b/features/wishlist/presentation/view_model/wishlist_view_model.dart';
import 'package:batch34_b/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final ThemeBloc _themeBloc;
  late final ProximityThemeManager _proximityManager;

  @override
  void initState() {
    super.initState();

    _themeBloc = ThemeBloc();

    // Correct: use the themeBloc as required by your constructor
    _proximityManager = ProximityThemeManager(themeBloc: _themeBloc);
  }

  @override
  void dispose() {
    _proximityManager?.dispose();
    _themeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashscreenViewModel>.value(
          value: serviceLocator<SplashscreenViewModel>(),
        ),
        BlocProvider<CourseBloc>(create: (_) => serviceLocator<CourseBloc>()),
        Provider<GetLessonsByCourseUseCase>(
          create:
              (context) =>
                  GetLessonsByCourseUseCase(context.read<CourseRepository>()),
        ),
        BlocProvider<LessonBloc>(create: (_) => serviceLocator<LessonBloc>()),
        BlocProvider<PaymentBloc>(create: (_) => serviceLocator<PaymentBloc>()),
        BlocProvider<WishlistBloc>(
          create: (_) {
            final bloc = serviceLocator<WishlistBloc>();
            bloc.add(LoadWishlist(userId: 'USER_ID_HERE'));
            return bloc;
          },
        ),
        BlocProvider<ThemeBloc>(create: (_) => _themeBloc),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            theme: getApplicationTheme(),
            darkTheme: ThemeData.dark(),
            themeMode: state.themeMode,
            debugShowCheckedModeBanner: false,
            home: const SplashscreenView(),
            onGenerateRoute: (settings) {
              if (settings.name == '/payment') {
                final lesson = settings.arguments as LessonEntity;
                return MaterialPageRoute(
                  builder: (_) => PaymentFormView(lesson: lesson),
                );
              }
              return MaterialPageRoute(
                builder: (_) => const SplashscreenView(),
              );
            },
          );
        },
      ),
    );
  }
}
