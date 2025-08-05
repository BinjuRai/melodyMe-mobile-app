// lib/features/notification/presentation/screens/notification_screen.dart
import 'package:batch34_b/features/notification/domain/usecase/get_notifications_usecase.dart';
import 'package:batch34_b/features/notification/presentation/view_model/notification_event.dart';
import 'package:batch34_b/features/notification/presentation/view_model/notification_state.dart';
import 'package:batch34_b/features/notification/presentation/view_model/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationScreen extends StatelessWidget {
  final String userId;

  NotificationScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              NotificationBloc(context.read<GetNotificationsUseCase>())
                ..add(FetchNotifications(userId)),
      child: Scaffold(
        appBar: AppBar(title: Text('Notifications')),
        body: BlocBuilder<NotificationBloc, NotificationState>(
          builder: (context, state) {
            if (state is NotificationLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is NotificationError) {
              return Center(child: Text(state.message));
            }
            if (state is NotificationLoaded) {
              return ListView.builder(
                itemCount: state.notifications.length,
                itemBuilder: (context, index) {
                  final notification = state.notifications[index];
                  return ListTile(
                    title: Text(notification.message),
                    subtitle: Text(notification.createdAt.toString()),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
