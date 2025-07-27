import 'package:batch34_b/features/payment/data/data_source/remote_data_source/payament_remote_data_source.dart';
import 'package:batch34_b/features/payment/data/model/payment_api_model.dart';

abstract class PaymentDataSource {
  Future<PaymentModel> fetchPaymentById(String id);
  Future<PaymentModel> addPayment(PaymentModel payment);
  Future<void> removePayment(String id);
  Future<List<PaymentModel>> fetchAllPayments();
  Future<PaymentModel> modifyPayment(PaymentModel payment);
}

class PaymentDataSourceImpl implements PaymentDataSource {
  final PaymentRemoteDataSource remoteDataSource;

  PaymentDataSourceImpl(this.remoteDataSource);

  @override
  Future<PaymentModel> fetchPaymentById(String id) {
    return remoteDataSource.getPaymentById(id);
  }

  @override
  Future<PaymentModel> addPayment(PaymentModel payment) {
    return remoteDataSource.createPayment(payment);
  }

  @override
  Future<void> removePayment(String id) {
    return remoteDataSource.deletePayment(id);
  }

  @override
  Future<List<PaymentModel>> fetchAllPayments() {
    return remoteDataSource.getAllPayments();
  }

  @override
  Future<PaymentModel> modifyPayment(PaymentModel payment) {
    return remoteDataSource.updatePayment(payment);
  }
}
