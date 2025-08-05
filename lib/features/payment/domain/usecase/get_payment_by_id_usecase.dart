

import 'package:batch34_b/features/payment/domain/entity/payment_entity.dart';
import 'package:batch34_b/features/payment/domain/repository/payment_repository.dart';

class GetPaymentByIdUseCase {
  final PaymentRepository repository;

  GetPaymentByIdUseCase(this.repository);

  Future<PaymentEntity> call(String id) {
    return repository.getPaymentById(id);
  }
}
