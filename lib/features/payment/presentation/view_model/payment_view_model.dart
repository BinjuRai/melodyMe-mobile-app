import 'package:batch34_b/features/payment/domain/usecase/create_payment_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:batch34_b/features/payment/domain/repository/payment_repository.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository paymentRepository;
  final CreatePaymentUseCase createPaymentUseCase;

  // Correct constructor with both parameters required
  PaymentBloc({
    required this.paymentRepository,
    required this.createPaymentUseCase,
  }) : super(PaymentInitial()) {
    on<LoadPaymentById>(_onLoadPaymentById);
    on<CreatePayment>(_onCreatePayment);
  }

  Future<void> _onLoadPaymentById(
    LoadPaymentById event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      final payment = await paymentRepository.getPaymentById(event.id);
      emit(PaymentLoaded(payment));
    } catch (e) {
      emit(PaymentError('Failed to load payment: ${e.toString()}'));
    }
  }

  Future<void> _onCreatePayment(
    CreatePayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    try {
      print('📦 Creating payment...');
      final createdPayment = await createPaymentUseCase(event.payment);
      print(
        '✅ Payment created with id: ${createdPayment.id}, type: ${createdPayment.type}',
      ); // Use use case here
      emit(PaymentCreated(createdPayment));
    } catch (e) {
      print('❌ Payment creation failed: $e');
      emit(PaymentError('Failed to create payment: ${e.toString()}'));
    }
  }
}
