import 'package:batch34_b/features/payment/data/model/course_info_model.dart';
import 'package:batch34_b/features/payment/data/model/lesson_info_model.dart';
import 'package:batch34_b/features/payment/data/model/payment_api_model.dart';
import 'package:batch34_b/features/payment/data/model/user_info_model.dart';
import 'package:batch34_b/features/payment/domain/entity/payment_entity.dart';
import 'package:batch34_b/features/payment/domain/repository/payment_repository.dart';
import 'package:dio/dio.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final Dio dio;
  final String baseUrl;

  PaymentRepositoryImpl({required this.dio, required this.baseUrl});

  @override
  Future<PaymentEntity> getPaymentById(String id) async {
    try {
      final response = await dio.get('${baseUrl}payment/$id');

      if (response.statusCode == 200) {
        final paymentModel = PaymentModel.fromJson(response.data);
        return paymentModel.toEntity();
      } else {
        throw Exception('Failed to load payment');
      }
    } catch (e) {
      throw Exception('Error fetching payment: $e');
    }
  }

  @override
 
  Future<PaymentEntity> createPayment(PaymentEntity payment) async {
    try {
      final paymentModel = PaymentModel(
        id: payment.id,
        pricePaid: payment.pricePaid,
        paymentMethod: payment.paymentMethod,
        paymentStatus: payment.paymentStatus,
        paymentDate: payment.paymentDate.toIso8601String(),
        userId: payment.userId,
        username: payment.username,
        courseId: payment.courseId,
        lessonId: payment.lessonId,
        type: payment.type,
      );

      final response = await dio.post(
        '${baseUrl}payment',
        data: paymentModel.toRequestJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 201) {
        final createdPayment = PaymentModel.fromJson(response.data['payment']);
        return createdPayment.toEntity();
      } else {
        throw Exception('Failed to create payment');
      }
    } catch (e) {
      throw Exception('Error creating payment: $e');
    }
  }

  @override
  Future<void> deletePayment(String id) async {
    try {
      final response = await dio.delete('${baseUrl}payment/$id');

      if (response.statusCode != 204) {
        throw Exception('Failed to delete payment');
      }
    } catch (e) {
      throw Exception('Error deleting payment: $e');
    }
  }

  @override
  Future<List<PaymentEntity>> getAllPayments() async {
    try {
      final response = await dio.get('${baseUrl}payment/all');

      if (response.statusCode == 200) {
        final List dataList = response.data as List;
        final payments =
            dataList
                .map((json) => PaymentModel.fromJson(json).toEntity())
                .toList();
        return payments;
      } else {
        throw Exception('Failed to load payments');
      }
    } catch (e) {
      throw Exception('Error fetching payments: $e');
    }
  }

  @override
  
  Future<PaymentEntity> updatePayment(PaymentEntity payment) async {
    try {
      final paymentModel = PaymentModel(
        id: payment.id,
        pricePaid: payment.pricePaid,
        paymentMethod: payment.paymentMethod,
        paymentStatus: payment.paymentStatus,
        paymentDate: payment.paymentDate.toIso8601String(),
        userId: payment.userId,
        username: payment.username,
        courseId: payment.courseId,
        lessonId: payment.lessonId,
        type: payment.type,
      );

      final response = await dio.put(
        '${baseUrl}payment/${payment.id}',
        data: paymentModel.toRequestJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final updatedPayment = PaymentModel.fromJson(response.data['payment']);
        return updatedPayment.toEntity();
      } else {
        throw Exception('Failed to update payment');
      }
    } catch (e) {
      throw Exception('Error updating payment: $e');
    }
  }
}
