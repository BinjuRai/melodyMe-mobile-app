

import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class ChangePassword {
  final IUserRepository _userRepository;

  ChangePassword({required IUserRepository userRepository})
      : _userRepository = userRepository;

  Future<Either<Failure, void>> call(String oldPassword, String newPassword) {
    return _userRepository.changePassword(oldPassword, newPassword);
  }
}
