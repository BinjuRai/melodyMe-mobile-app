// lib/features/notification/models/notification_model.dart
import 'package:hive/hive.dart';

part 'notification_model.g.dart'; // Generated file for Hive.

@HiveType(typeId: 0)
class NotificationModel {
  @HiveField(0)
  final String message;

  @HiveField(1)
  final String courseId;

  @HiveField(2)
  final String lessonId;

  @HiveField(3)
  final DateTime createdAt;

  NotificationModel({
    required this.message,
    required this.courseId,
    required this.lessonId,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      message: json['message'],
      courseId: json['courseId'],
      lessonId: json['lessonId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
