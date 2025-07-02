import 'package:batch34_b/app/service_locator/service_locator.dart';
import 'package:batch34_b/features/splash/presentation/view/splashScreen_view.dart';
import 'package:batch34_b/features/splash/presentation/view_model/splashscreen_view_model.dart';
import 'package:batch34_b/theme/theme_data.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // main theme of the app
      // theme as in the customizable themes in androids
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      home: BlocProvider.value(
        value: serviceLocator<SplashscreenViewModel>(),
        child: SplashscreenView(),
      ),
    );
  }
}
