import 'package:flutter/material.dart';
import 'package:batch34_b/features/splash/presentation/view_model/splashscreen_view_model.dart';

class SplashscreenView extends StatefulWidget {
  const SplashscreenView({super.key});

  @override
  State<SplashscreenView> createState() => _SplashscreenViewState();
}

class _SplashscreenViewState extends State<SplashscreenView> {
  final SplashscreenViewModel _viewModel = SplashscreenViewModel();

  @override
  void initState() {
    super.initState();
    _viewModel.init(context); // Delegate logic to ViewModel
  }

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
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset('assets/images/melodymelogo.png', width: 65),
                        Image.asset('assets/images/splashscreen_img1.png', width: 45),
                        Image.asset('assets/images/splashscreen_img1.png', width: 35),
                        Image.asset('assets/images/splashscreen_img1.png', width: 45),
                        Image.asset('assets/images/melodymelogo.png', width: 65),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const CircularProgressIndicator(color: Colors.white),
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
