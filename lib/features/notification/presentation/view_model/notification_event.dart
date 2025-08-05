// lib/features/notification/presentation/bloc/notification_event.dart


import 'package:equatable/equatable.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class FetchNotifications extends NotificationEvent {
  final String userId;

  const FetchNotifications(this.userId);

  @override
  List<Object> get props => [userId];
}
