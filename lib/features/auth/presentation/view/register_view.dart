
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
