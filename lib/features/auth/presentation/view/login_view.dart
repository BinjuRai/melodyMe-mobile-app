// import 'package:batch34_b/bottom_screen/dashboard.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_event.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class LoginView extends StatelessWidget {
//   LoginView({super.key});

//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController(text: 'lily@gmail.com');
//   final _passwordController = TextEditingController(text: 'password');
//   final _gap = const SizedBox(height: 16);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF222740),
//       body: Stack(
//         children: [
//           const Positioned(
//             top: 0,
//             right: 0,
//             child: Image(
//               image: AssetImage('assets/images/img2.png'),
//               width: 425,
//             ),
//           ),
//           const Positioned(
//             bottom: 0,
//             left: 0,
//             child: Image(
//               image: AssetImage('assets/images.png'),
//               width: 425,
//             ),
//           ),
//           SafeArea(
//             child: Center(
//               child: SingleChildScrollView(
//                 padding: const EdgeInsets.symmetric(horizontal: 32.0),
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text(
//                         'MelodyMe',
//                         style: TextStyle(
//                           fontSize: 36,
//                           color: Colors.white,
//                           fontFamily: 'Bagel_Fat_One',
//                         ),
//                       ),
//                       const SizedBox(height: 32),
//                       TextFormField(
//                         key: const ValueKey('email'),
//                         controller: _emailController,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           hintText: 'Email address',
//                           prefixIcon: const Icon(
//                             Icons.email_outlined,
//                             color: Color.fromARGB(255, 60, 57, 57),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           }
//                           return null;
//                         },
//                       ),
//                       _gap,
//                       TextFormField(
//                         key: const ValueKey('password'),
//                         controller: _passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: Colors.white,
//                           hintText: 'Password',
//                           prefixIcon: const Icon(
//                             Icons.lock_outline,
//                             color: Color.fromARGB(255, 60, 57, 57),
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your password';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 24),
//                       ElevatedButton(
//                         onPressed: () {
//                           if (_formKey.currentState!.validate()) {
//                             context.read<LoginViewModel>().add(
//                               LoginWithEmailAndPasswordEvent(
//                                 context: context,
//                                 email: _emailController.text,
//                                 password: _passwordController.text,
//                               ),
//                             );
//                           }
//                           //   Navigator.push(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //       builder: (context) => const DashboardScreen(),
//                           //     ),
//                           //   );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: const Color(0xFF222740),
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 48,
//                             vertical: 14,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text(
//                           'Login',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontFamily: 'Playfair_Display',
//                             color: Color.fromARGB(255, 11, 27, 42),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       ElevatedButton(
//                         key: const ValueKey('registerButton'),
//                         onPressed: () {
//                           context.read<LoginViewModel>().add(
//                             NavigateToRegisterViewEvent(context: context),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.white,
//                           foregroundColor: const Color(0xFF222740),
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 48,
//                             vertical: 14,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: const Text(
//                           'Register',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontFamily: 'Playfair_Display',
//                             color: Color.fromARGB(255, 11, 27, 42),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  // final _formKey = GlobalKey<FormState>();
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  // final _gap = const SizedBox(height: 16);
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'lily@gmail.com');
  final _passwordController = TextEditingController(text: 'password');
  final _gap = const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset('assets/images/vocals.png', fit: BoxFit.cover),
          ),

          // Color Overlay (Dark Blue with opacity)
          Positioned.fill(
            child: Container(
              color: const Color.fromARGB(255, 20, 24, 49).withOpacity(0.8),
            ),
          ),

          // Main content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        '🎶 MelodyMe 🎵',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Bagel_Fat_One',
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Email
                      _buildInputField(
                        controller: _emailController,
                        hint: 'Enter your email',
                        icon: Icons.email,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                      ),
                      _gap,

                      // Password
                      _buildInputField(
                        controller: _passwordController,
                        hint: 'Enter your password',
                        icon: Icons.lock,
                        obscure: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      // Login Button
                      _buildActionButton(
                        text: '🎧 Login',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginViewModel>().add(
                              LoginWithEmailAndPasswordEvent(
                                context: context,
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 12),

                      // Register Link
                      TextButton(
                        onPressed: () {
                          context.read<LoginViewModel>().add(
                            NavigateToRegisterViewEvent(context: context),
                          );
                        },
                        child: const Text(
                          "Don't have an account? Register 🎤",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.black),
        fillColor: Colors.white.withOpacity(0.9),
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF222740),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Playfair_Display',
          ),
        ),
      ),
    );
  }
}
