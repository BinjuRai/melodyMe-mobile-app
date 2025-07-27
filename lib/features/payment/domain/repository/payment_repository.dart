

import 'package:batch34_b/features/payment/domain/entity/payment_entity.dart';

abstract class PaymentRepository {
  Future<List<PaymentEntity>> getAllPayments();
  Future<PaymentEntity> getPaymentById(String id);
  Future<PaymentEntity> createPayment(PaymentEntity payment);
  Future<PaymentEntity> updatePayment(PaymentEntity payment);
  Future<void> deletePayment(String id);
}
