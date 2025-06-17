import 'package:batch34_b/view/login_view.dart';
import 'package:batch34_b/view/registration_view.dart';
import 'package:flutter/material.dart';

class SpashscreenSecondView extends StatefulWidget {
  const SpashscreenSecondView({super.key});

  @override
  State<SpashscreenSecondView> createState() => _SpashscreenSecondViewState();
}

class _SpashscreenSecondViewState extends State<SpashscreenSecondView> {
  @override
  Widget build(BuildContext context) {
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

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    },
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

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegistrationView(),
                        ),
                      );
                    },
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
