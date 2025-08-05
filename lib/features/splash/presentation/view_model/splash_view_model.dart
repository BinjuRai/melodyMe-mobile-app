import 'package:batch34_b/features/auth/presentation/view/register_view.dart';
import 'package:flutter/material.dart';
import 'package:batch34_b/features/auth/presentation/view/login_view.dart';



import 'package:flutter_bloc/flutter_bloc.dart';

class SplashViewModel extends Cubit<void> {
  SplashViewModel() : super(null);

  /// Navigate to login screen
  void navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  /// Navigate to signup screen
  void navigateToSignup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationView()),
    );
  }
}
