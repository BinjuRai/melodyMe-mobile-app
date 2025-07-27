import 'package:batch34_b/app/service_locator/service_locator.dart';
import 'package:batch34_b/features/payment/presentation/view_model/payment_event.dart';
import 'package:batch34_b/features/payment/presentation/view_model/payment_state.dart';
import 'package:batch34_b/features/payment/presentation/view_model/payment_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentView extends StatelessWidget {
  final String paymentId;

  const PaymentView({Key? key, required this.paymentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) => serviceLocator<PaymentBloc>()..add(LoadPaymentById(paymentId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Payment Details')),
        body: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            if (state is PaymentLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PaymentLoaded) {
              final p = state.payment;
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildDetailRow('Payment ID', p.id),
                  _buildDetailRow('User', p.username ?? 'Unknown'),
                  _buildDetailRow('Course ID', p.courseId),
                  _buildDetailRow('Lesson ID', p.lessonId ?? 'N/A'),
                  _buildDetailRow(
                    'Price Paid',
                    '\$${p.pricePaid.toStringAsFixed(2)}',
                  ),
                  _buildDetailRow('Payment Method', p.paymentMethod),
                  _buildDetailRow('Status', p.paymentStatus),
                  _buildDetailRow('Date', _formatDate(p.paymentDate)),
                ],
              );
            } else if (state is PaymentError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Format date nicely e.g. "Jul 25, 2025 14:30"
    return '${date.month}/${date.day}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
