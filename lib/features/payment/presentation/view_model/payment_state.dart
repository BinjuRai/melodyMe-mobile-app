import 'package:equatable/equatable.dart';
import 'package:batch34_b/features/payment/domain/entity/payment_entity.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentLoaded extends PaymentState {
  final PaymentEntity payment;

  const PaymentLoaded(this.payment);

  @override
  List<Object?> get props => [payment];
}

class PaymentCreated extends PaymentState {
  final PaymentEntity payment;

  const PaymentCreated(this.payment);

  @override
  List<Object?> get props => [payment];
}

class PaymentError extends PaymentState {
  final String message;

  const PaymentError(this.message);

  @override
  List<Object?> get props => [message];
}
