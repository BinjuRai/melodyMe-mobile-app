import 'package:batch34_b/app/service_locator/service_locator.dart';
import 'package:batch34_b/features/auth/presentation/view/login_view.dart';
import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:batch34_b/features/splash/presentation/view/splash_view.dart';
import 'package:batch34_b/features/splash/presentation/view_model/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SplashscreenViewModel extends Cubit<void> {
  SplashscreenViewModel() : super(null);
  // Open Login View after 2 seconds
  Future<void> init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3), () async {
      // Open Login page or Onboarding Screen

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => BlocProvider.value(
                  value: serviceLocator<LoginViewModel>(),
                  child: LoginView(),
                ),
          ),
        );
      }
    });
  }
}
