import 'package:batch34_b/app/use_case/usecase.dart';
import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/auth/domain/entity/user_entity.dart';
import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUserParams extends Equatable {
  final String username;
  final String phone;
  final String email;
  final String password;
  final String? image;

  const RegisterUserParams({
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    this.image,
  });

  //intial constructor
  const RegisterUserParams.initial({
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    this.image,
  });

  @override
  List<Object?> get props => [username, phone, email, password];
}

class UserRegisterUsecase
    implements UsecaseWithParams<void, RegisterUserParams> {
  final IUserRepository _userRepository;

  UserRegisterUsecase({required IUserRepository userRepository})
    : _userRepository = userRepository;

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final userEntity = UserEntity(
      username: params.username,
      phone: params.phone,
      email: params.email,
      password: params.password,
      image: params.image,
    );
    return _userRepository.registerUser(userEntity);
  }
}
