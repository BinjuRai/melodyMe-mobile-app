

import 'package:batch34_b/features/notification/data/model/notification_model.dart';
import 'package:batch34_b/features/notification/data/repository/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository repository;

  GetNotificationsUseCase(this.repository);

  Future<List<NotificationModel>> call(String userId) async {
    return await repository.fetchNotifications(userId);
  }
}
