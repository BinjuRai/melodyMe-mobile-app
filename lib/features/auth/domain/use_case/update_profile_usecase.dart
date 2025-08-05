import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';
import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';


class UpdateProfile {
  final IUserRepository _userRepository;

  UpdateProfile({required IUserRepository userRepository})
      : _userRepository = userRepository;

  Future<Either<Failure, UserEntity>> call(Map<String, dynamic> updates) {
    return _userRepository.updateProfile(updates);
  }
}
