import 'package:batch34_b/features/payment/data/model/payment_api_model.dart';
import 'package:dio/dio.dart';

abstract class PaymentRemoteDataSource {
  Future<PaymentModel> getPaymentById(String id);
  Future<PaymentModel> createPayment(PaymentModel payment);
  Future<void> deletePayment(String id);
  Future<List<PaymentModel>> getAllPayments();
  Future<PaymentModel> updatePayment(PaymentModel payment);
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final Dio dio;
  final String baseUrl;

  PaymentRemoteDataSourceImpl({required this.dio, required this.baseUrl});

  @override
  Future<PaymentModel> getPaymentById(String id) async {
    final response = await dio.get('payment/$id');
    if (response.statusCode == 200) {
      return PaymentModel.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch payment');
    }
  }

  @override
  Future<PaymentModel> createPayment(PaymentModel payment) async {
    final response = await dio.post(
      'payment',
      data: payment.toJson(),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    if (response.statusCode == 201) {
      return PaymentModel.fromJson(response.data);
    } else {
      throw Exception('Failed to create payment');
    }
  }

  @override
  Future<void> deletePayment(String id) async {
    final response = await dio.delete('payment/$id');
    if (response.statusCode != 204) {
      throw Exception('Failed to delete payment');
    }
  }

  @override
  Future<List<PaymentModel>> getAllPayments() async {
    final response = await dio.get('payment');
    if (response.statusCode == 200) {
      final List<dynamic> list = response.data;
      return list.map((json) => PaymentModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load payments');
    }
  }

  @override
  Future<PaymentModel> updatePayment(PaymentModel payment) async {
    final response = await dio.put(
      '$baseUrl/payment/${payment.id}',
      data: payment.toJson(),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    if (response.statusCode == 200) {
      return PaymentModel.fromJson(response.data);
    } else {
      throw Exception('Failed to update payment');
    }
  }
}
