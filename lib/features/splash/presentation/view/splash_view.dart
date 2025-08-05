import 'package:batch34_b/features/splash/presentation/view_model/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<SplashViewModel>();

    return Scaffold(
      body: Stack(
        children: [
          const Positioned(
            top: -8,
            left: -15,
            child: Image(
              image: AssetImage('assets/images/top_violin.png'),
              width: 430,
            ),
          ),
          const Positioned(
            bottom: -10,
            right: -12,
            child: Image(
              image: AssetImage('assets/images/bottom_guitar.png'),
              width: 430,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'WELCOME TO',
                    style: TextStyle(
                      fontFamily: 'Playfair_Display',
                      fontSize: 21,
                      color: Color(0xFF222740),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'MelodyMe',
                    style: TextStyle(
                      fontSize: 36,
                      color: Color(0xFF222740),
                      fontFamily: 'Bagel_Fat_One',
                    ),
                  ),
                  const SizedBox(height: 25),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF222740),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 4,
                    ),
                    onPressed: () => viewModel.navigateToLogin(context),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontFamily: 'Playfair_Display',
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(color: Color(0xFF222740)),
                    ),
                    onPressed: () => viewModel.navigateToSignup(context),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Color(0xFF222740)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
