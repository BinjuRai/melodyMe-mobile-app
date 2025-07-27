// lib/features/notification/data/notification_remote_data_source.dart
import 'dart:convert';
import 'package:batch34_b/features/notification/data/model/notification_model.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

class NotificationRemoteDataSource {
  final  dioClient;

  NotificationRemoteDataSource(this.dioClient);

  Future<List<NotificationModel>> fetchNotifications(String userId) async {
    try {
      // Making the API call
      final response = await dioClient.get('notifications/$userId');

      // Handling the response
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.data);
        return data.map((e) => NotificationModel.fromJson(e)).toList();
      } else {
        // If response is not successful, throw a custom error
        throw Exception('Failed to load notifications');
      }
    } on DioException catch (dioError) {
      // If Dio error occurs, propagate the error with the custom message
      throw Exception('Error fetching notifications: ${dioError.error}');
    } catch (e) {
      // Catching any other unknown errors
      throw Exception('Unexpected error occurred: $e');
    }
  }
}
