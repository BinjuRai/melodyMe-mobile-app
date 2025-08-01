import 'dart:ui';

import 'package:batch34_b/app/service_locator/service_locator.dart';
import 'package:batch34_b/app/share_pref/token_shared_pref.dart';
import 'package:batch34_b/core/common/jwt_helper.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:batch34_b/features/lesson/presentation/view/lesson_view.dart';
import 'package:batch34_b/features/payment/domain/entity/payment_entity.dart';
import 'package:batch34_b/features/payment/presentation/view_model/payment_event.dart';
import 'package:batch34_b/features/payment/presentation/view_model/payment_state.dart';
import 'package:batch34_b/features/payment/presentation/view_model/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentFormView extends StatefulWidget {
  final LessonEntity lesson;

  const PaymentFormView({Key? key, required this.lesson}) : super(key: key);

  @override
  State<PaymentFormView> createState() => _PaymentFormViewState();
}

class _PaymentFormViewState extends State<PaymentFormView> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();

  String _selectedMethod = 'eSewa';
  final List<String> _methods = ['eSewa', 'FonePay', 'BankTransfer'];

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  // void _submitPayment() {
  //   if (_formKey.currentState!.validate()) {
  //     final payment = PaymentEntity(
  //       id: '',
  //       userId: '', // Replace with actual logged-in user ID
  //       username: _usernameController.text,
  //       courseId: widget.lesson.courseId!,
  //       courseTitle: widget.lesson.name,
  //       lessonId: widget.lesson.id,
  //       lessonTitle: widget.lesson.name,
  //       pricePaid: widget.lesson.price,
  //       paymentMethod: _selectedMethod,
  //       paymentStatus: 'pending',
  //       paymentDate: DateTime.now(),
  //     );

  //     context.read<PaymentBloc>().add(CreatePayment(payment));
  //   }
  // }
  void _submitPayment() async {
    if (_formKey.currentState!.validate()) {
      // Step 1: Get the token
      final tokenResult = await serviceLocator<TokenSharedPrefs>().getToken();

      String? userId;

      tokenResult.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error reading token: ${failure.message}')),
          );
        },
        (token) {
          if (token != null) {
            userId = JwtDecoderHelper.getUserIdFromToken(token);
          }
        },
      );

      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not logged in. Please log in again.'),
          ),
        );
        return;
      }

      // Step 2: Create the payment
      final payment = PaymentEntity(
        id: '',
        userId: userId!,
        username: _usernameController.text, // ✅ Set username here
        // username: _usernameController.text,
        courseId: widget.lesson.courseId!,
        // courseTitle: widget.lesson.name,
        lessonId: widget.lesson.id,
        lessonTitle: widget.lesson.name,
        pricePaid: widget.lesson.price,
        paymentMethod: _selectedMethod,
        paymentStatus: 'pending',
        paymentDate: DateTime.now(),
        type: 'lesson', // Assuming type is 'lesson' for this payment
      );
      print('Submitting payment with type: ${payment.type}');

      // Step 3: Dispatch event
      context.read<PaymentBloc>().add(CreatePayment(payment));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Join Lesson')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<PaymentBloc, PaymentState>(
          // listener: (context, state) {
          //   if (state is PaymentCreated) {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       const SnackBar(
          //         content: Text('Payment created successfully!'),
          //       ),
          //     );
          //     Navigator.pop(context); // Go back after submission
          //   } else if (state is PaymentError) {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //       SnackBar(content: Text('Error: ${state.message}')),
          //     );
          //   }
          // },
          listener: (context, state) {
            if (state is PaymentCreated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Payment created successfully!'),
                  backgroundColor: Colors.green,
                ),
              );

              // Navigate to LessonView after short delay (optional)
              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pop(context);
              });
            } else if (state is PaymentError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error: ${state.message}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is PaymentLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(labelText: 'Your Name'),
                    validator:
                        (value) =>
                            value == null || value.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),

                  Text('Course: ${widget.lesson.name}'),
                  const SizedBox(height: 8),

                  Text('Lesson: ${widget.lesson.name}'),
                  const SizedBox(height: 8),

                  Text('Price: Rs. ${widget.lesson.price.toStringAsFixed(2)}'),
                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: _selectedMethod,
                    decoration: const InputDecoration(
                      labelText: 'Payment Method',
                    ),
                    items:
                        _methods
                            .map(
                              (method) => DropdownMenuItem(
                                value: method,
                                child: Text(method),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedMethod = value;
                        });
                      }
                    },
                  ),

                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submitPayment,
                    child: const Text('Confirm & Pay'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
