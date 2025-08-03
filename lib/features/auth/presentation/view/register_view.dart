// import 'package:batch34_b/features/auth/presentation/view_model/register_view_model/register_event.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class RegistrationView extends StatelessWidget {
//   RegistrationView({super.key});

//   final _formKey = GlobalKey<FormState>();

//   final _usernameController = TextEditingController(text: 'Binju');
//   final _phoneController = TextEditingController(text: '123456789');
//   final _emailController = TextEditingController(text: 'binju@gmail.com');
//   final _passwordController = TextEditingController(text: 'password');

//   final _gap = const SizedBox(height: 8);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           const Positioned(
//             top: 0,
//             right: 0,
//             child: Image(
//               image: AssetImage('assets/images/vocals.png'),
//               width: 430,
//             ),
//           ),
//           const Positioned(
//             bottom: -10,
//             left: -12,
//             child: Image(
//               image: AssetImage('assets/images/.png'),
//               width: 430,
//             ),
//           ),
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 32.0),
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text(
//                         'MelodyMe',
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Color.fromARGB(255, 30, 10, 10),
//                           fontFamily: 'Bagel Fat One',
//                         ),
//                       ),
//                       const SizedBox(height: 32),

//                       // Username
//                       const Text(
//                         "Username",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       _gap,
//                       TextFormField(
//                         controller: _usernameController,
//                         decoration: InputDecoration(
//                           hintText: "Enter your username",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your username';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16),

//                       // Phone
//                       const Text(
//                         "Phone No.",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       _gap,
//                       TextFormField(
//                         controller: _phoneController,
//                         decoration: InputDecoration(
//                           hintText: "Enter your phone number",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your phone number';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16),

//                       // Email
//                       const Text(
//                         "Email Address",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       _gap,
//                       TextFormField(
//                         controller: _emailController,
//                         decoration: InputDecoration(
//                           hintText: "Enter your email",
//                           prefixIcon: const Icon(Icons.email),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           }
//                           if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                             return 'Enter a valid email';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16),

//                       // Password
//                       const Text(
//                         "Password",
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       _gap,
//                       TextFormField(
//                         controller: _passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                           hintText: "Enter your password",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           contentPadding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                           ),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your password';
//                           }
//                           if (value.length < 6) {
//                             return 'Password must be at least 6 characters';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16),

//                       // Sign Up Button
//                       SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               context.read<RegisterViewModel>().add(
//                                 RegisterUserEvent(
//                                   context: context,
//                                   username: _usernameController.text.trim(),
//                                   phone: _phoneController.text.trim(),
//                                   email: _emailController.text.trim(),
//                                   password: _passwordController.text.trim(),
//                                 ),
//                               );
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF222740),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                           ),
//                           child: const Text(
//                             "Sign up",
//                             style: TextStyle(fontSize: 18, color: Colors.white),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 10),

//                       // Google Signup
//                       // const Text('or'),
//                       // const SizedBox(height: 10),
//                       // Container(
//                       //   padding: const EdgeInsets.all(12),
//                       //   decoration: BoxDecoration(
//                       //     color: Colors.white,
//                       //     borderRadius: BorderRadius.circular(8),
//                       //     boxShadow: [
//                       //       BoxShadow(
//                       //         color: Colors.grey.shade300,
//                       //         blurRadius: 6,
//                       //       ),
//                       //     ],
//                       //   ),
//                       //   child: Row(
//                       //     mainAxisAlignment: MainAxisAlignment.center,
//                       //     children: const [
//                       //       Icon(Icons.g_mobiledata, size: 32),
//                       //       SizedBox(width: 8),
//                       //       Text('Signup with Google'),
//                       //     ],
//                       //   ),
//                       // ),
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
import 'package:batch34_b/features/auth/presentation/view_model/register_view_model/register_event.dart';
import 'package:batch34_b/features/auth/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationView extends StatelessWidget {
  RegistrationView({super.key});

  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _gap = const SizedBox(height: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        foregroundColor: const Color(0xFF222740),
      ),
      backgroundColor: const Color(0xFFDDE1F0),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Text(
                    '🎵 MelodyMe',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF222740),
                      fontFamily: 'Bagel_Fat_One',
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Create your musical journey',
                    style: TextStyle(fontSize: 16, color: Color(0xFF222740)),
                  ),
                  const SizedBox(height: 24),

                  _buildLabel("👤 Username"),
                  _gap,
                  _buildTextField(
                    controller: _usernameController,
                    hint: "Enter your username",
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Please enter your username'
                                : null,
                  ),

                  const SizedBox(height: 16),
                  _buildLabel("📱 Phone Number"),
                  _gap,
                  _buildTextField(
                    controller: _phoneController,
                    hint: "Enter your phone number",
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? 'Please enter your phone number'
                                : null,
                  ),

                  const SizedBox(height: 16),
                  _buildLabel("📧 Email"),
                  _gap,
                  _buildTextField(
                    controller: _emailController,
                    hint: "Enter your email",
                    icon: Icons.email,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please enter your email';
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),
                  _buildLabel("🔒 Password"),
                  _gap,
                  _buildTextField(
                    controller: _passwordController,
                    hint: "Enter your password",
                    obscure: true,
                    validator: (value) {
                      if (value == null || value.isEmpty)
                        return 'Please enter your password';
                      if (value.length < 6)
                        return 'Password must be at least 6 characters';
                      return null;
                    },
                  ),

                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<RegisterViewModel>().add(
                            RegisterUserEvent(
                              context: context,
                              username: _usernameController.text.trim(),
                              phone: _phoneController.text.trim(),
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.music_note),
                      label: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF222740),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xFF222740),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon, color: Color(0xFF222740)) : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        filled: true,
        fillColor: const Color(0xFFF0C5CE),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
      ),
      validator: validator,
    );
  }
}
