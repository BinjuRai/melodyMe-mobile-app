

import 'package:batch34_b/features/payment/domain/entity/payment_entity.dart';
import 'package:batch34_b/features/payment/domain/repository/payment_repository.dart';

class GetAllPaymentsUseCase {
  final PaymentRepository repository;

  GetAllPaymentsUseCase(this.repository);

  Future<List<PaymentEntity>> call() {
    return repository.getAllPayments();
  }
}
