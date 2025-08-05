

import 'package:batch34_b/features/payment/domain/entity/payment_entity.dart';
import 'package:batch34_b/features/payment/domain/repository/payment_repository.dart';

class CreatePaymentUseCase {
  final PaymentRepository repository;

  CreatePaymentUseCase(this.repository);

  Future<PaymentEntity> call(PaymentEntity payment) {
    return repository.createPayment(payment);
  }
}
