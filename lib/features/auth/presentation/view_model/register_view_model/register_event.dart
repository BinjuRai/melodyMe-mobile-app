import 'dart:io';

import 'package:flutter/widgets.dart';

@immutable
sealed class RegisterEvent {}

class LoadCoursesAndBatchesEvent extends RegisterEvent {}

class UploadImageEvent extends RegisterEvent {
  final File file;

  UploadImageEvent({required this.file});
}

class RegisterUserEvent extends RegisterEvent {
  final BuildContext context;

  final String username;
  final String phone;
  final String email;
  final String password;
  final String? image;

  RegisterUserEvent({
    required this.context,
    
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    this.image,
  });
}
