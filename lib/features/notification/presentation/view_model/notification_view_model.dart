// lib/features/notification/presentation/bloc/notification_bloc.dart
import 'package:batch34_b/features/notification/domain/usecase/get_notifications_usecase.dart';
import 'package:batch34_b/features/notification/presentation/view_model/notification_event.dart';
import 'package:batch34_b/features/notification/presentation/view_model/notification_state.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;

  NotificationBloc(this.getNotificationsUseCase) : super(NotificationInitial());

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is FetchNotifications) {
      yield NotificationLoading();
      try {
        final notifications = await getNotificationsUseCase(event.userId);
        yield NotificationLoaded(notifications);
      } catch (_) {
        yield NotificationError('Failed to fetch notifications');
      }
    }
  }
}
