
import 'package:batch34_b/theme/theme_data.dart';
import 'package:batch34_b/view/splashscreen_view.dart';

import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      home: SplashscreenView(),
    );
  }
}
