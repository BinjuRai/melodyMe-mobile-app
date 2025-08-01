import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';
import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';


class GetProfile {
  final IUserRepository _userRepository;
   

  GetProfile({required IUserRepository userRepository})
      : _userRepository = userRepository;

  Future<Either<Failure, UserEntity>> call() {
    return _userRepository.getProfile();
  }
}
