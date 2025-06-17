import 'package:flutter/material.dart';
import 'package:batch34_b/view/spashscreen_second_view.dart';

class SplashscreenView extends StatefulWidget {
  const SplashscreenView({super.key});

  @override
  State<SplashscreenView> createState() => _SplashscreenViewState();
}

class _SplashscreenViewState extends State<SplashscreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222740),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Image.asset(
                  'assets/images/splashscreen_img1.png',

                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Text(
                    //   'MelodyMe',
                    //   style: TextStyle(
                    //     fontSize: 36,
                    //     color: Colors.white,
                    //     fontFamily: 'Bagel_Fat_One',
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/images/melodymelogo.png',
                          width: 65,
                          fit: BoxFit.contain,
                        ),
                        Image.asset(
                          'assets/images/splashscreen_img1.png',
                          width: 45,
                          fit: BoxFit.contain,
                        ),
                        // const SizedBox(height: 30),
                        Image.asset(
                          'assets/images/splashscreen_img1.png',
                          width: 35,
                          fit: BoxFit.contain,
                        ),
                        Image.asset(
                          'assets/images/splashscreen_img1.png',
                          width: 45,
                          fit: BoxFit.contain,
                        ),
                        // const SizedBox(height: 30),
                        Image.asset(
                          'assets/images/melodymelogo.png',
                          width: 65,
                          fit: BoxFit.contain,
                        ),
                        // const SizedBox(height: 30),
                      
                      ],
                    ),
                
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF222740),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 6,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SpashscreenSecondView(),
                          ),
                        );
                      },
                      child: const Text(
                        "Let's Start",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
