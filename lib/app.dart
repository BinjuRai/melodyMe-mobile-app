import 'package:batch34_b/view/login_view.dart';
import 'package:batch34_b/view/registration_view.dart';
import 'package:batch34_b/view/spashscreen_second_view.dart';
import 'package:batch34_b/view/splashscreen_view.dart';

import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashscreenView(),
    );
  }
}
