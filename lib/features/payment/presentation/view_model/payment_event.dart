import 'package:batch34_b/features/payment/domain/entity/payment_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object?> get props => [];
}

class LoadPaymentById extends PaymentEvent {
  final String id;

  const LoadPaymentById(this.id);

  @override
  List<Object?> get props => [id];
}

class CreatePayment extends PaymentEvent {
  final PaymentEntity payment;

  const CreatePayment(this.payment);

  @override
  List<Object?> get props => [payment];
}
