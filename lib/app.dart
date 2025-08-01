import 'package:batch34_b/app/service_locator/service_locator.dart';
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

class App extends StatelessWidget {
  const App({super.key});

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
            bloc.add(
              LoadWishlist(userId: 'USER_ID_HERE'),
            ); // <-- Replace dynamically later
            return bloc;
          },
        ),
      ],
      child: MaterialApp(
        theme: getApplicationTheme(),
        debugShowCheckedModeBanner: false,
        home: const SplashscreenView(),
        onGenerateRoute: (settings) {
          if (settings.name == '/payment') {
            final lesson = settings.arguments as LessonEntity;
            return MaterialPageRoute(
              builder:
                  (_) => PaymentFormView(
                    lesson: lesson,
                  ), // 👈 Make sure this matches your view class
            );
          }

          return MaterialPageRoute(
            builder:
                (_) => const SplashscreenView(), // fallback if route not found
          );
        },
      ),
    );
  }
}

// import 'package:batch34_b/app/service_locator/service_locator.dart';
// import 'package:batch34_b/features/splash/presentation/view/splashScreen_view.dart';
// import 'package:batch34_b/features/splash/presentation/view/splash_view.dart';
// import 'package:batch34_b/features/splash/presentation/view_model/splash_view_model.dart';
// import 'package:batch34_b/features/splash/presentation/view_model/splashscreen_view_model.dart';
// import 'package:batch34_b/theme/theme_data.dart';

// import 'package:flutter/material.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // main theme of the app
//       // theme as in the customizable themes in androids
//       theme: getApplicationTheme(),
//       debugShowCheckedModeBanner: false,
//       home: BlocProvider.value(
//         value: serviceLocator<SplashscreenViewModel>(),
//         child: SplashscreenView(),
//       ),
//     );
//   }
// }

// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'MelodyMe',
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.getApplicationTheme(),
//       home: BlocProvider.value(
//         value: serviceLocator<SplashViewModel>(),
//         child: SplashView(),
//       ),
//     );
//   }
// }
