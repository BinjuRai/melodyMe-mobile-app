// lib/features/notification/data/notification_repository.dart
import 'package:batch34_b/features/notification/data/data_source/remote_data_source/notification_remote_data_source.dart';
import 'package:batch34_b/features/notification/data/model/notification_model.dart';
import 'package:hive/hive.dart';


class NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;
  final Box<NotificationModel> localStorage;

  NotificationRepository({
    required this.remoteDataSource,
    required this.localStorage,
  });

  Future<List<NotificationModel>> fetchNotifications(String userId) async {
    try {
      // First, try to load notifications from the local database.
      final notifications = localStorage.values.toList();
      if (notifications.isNotEmpty) {
        return notifications;
      } else {
        // If local storage is empty, fetch from the API.
        final fetchedNotifications = await remoteDataSource.fetchNotifications(userId);
        // Store them in local storage.
        for (var notification in fetchedNotifications) {
          await localStorage.add(notification);
        }
        return fetchedNotifications;
      }
    } catch (e) {
      throw Exception('Error fetching notifications: $e');
    }
  }
}
