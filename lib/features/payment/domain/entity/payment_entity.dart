import 'package:equatable/equatable.dart';

class PaymentEntity extends Equatable {
  final String id;
  final String userId;
  final String? username;

  final String courseId;
  final String? courseTitle;

  final String? lessonId;
  final String? lessonTitle;

  final double pricePaid;
  final String paymentMethod;
  final String paymentStatus;
  final DateTime paymentDate;
  final String? type;

  const PaymentEntity({
    required this.id,
    required this.userId,
    this.username,
    required this.courseId,
    this.courseTitle,
    this.lessonId,
    this.lessonTitle,
    required this.pricePaid,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.paymentDate,
    this.type,
  });

  /// Empty factory to initialize default state (e.g. for BLoC or forms)
  factory PaymentEntity.empty() {
    return PaymentEntity(
      id: '',
      userId: '',
      username: '',
      courseId: '',
      courseTitle: '',
      lessonId: '',
      lessonTitle: '',
      pricePaid: 0.0,
      paymentMethod: '',
      paymentStatus: '',
      paymentDate: DateTime.now(),
      type: '',
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    username,
    courseId,
    courseTitle,
    lessonId,
    lessonTitle,
    pricePaid,
    paymentMethod,
    paymentStatus,
    paymentDate,
    type
  ];
}
