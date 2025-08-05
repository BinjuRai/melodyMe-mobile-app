import 'package:batch34_b/app/share_pref/token_shared_pref.dart';
import 'package:batch34_b/core/error/failure.dart';
import 'package:batch34_b/features/auth/domain/repository/user_repository.dart';
import 'package:batch34_b/features/auth/domain/use_case/user_login_usecase.dart';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements IUserRepository {}

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

void main() {
  late MockUserRepository mockUserRepository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;
  late UserLoginUsecase usecase;

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tToken = 'abc123token';
  const tParams = LoginParams(email: tEmail, password: tPassword);

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    usecase = UserLoginUsecase(
      userRepository: mockUserRepository,
      tokenSharedPrefs: mockTokenSharedPrefs,
    );

    // Fallback for LoginParams if needed in future tests
    registerFallbackValue(const LoginParams(email: '', password: ''));
  });

  test('should call repository.loginUser with correct email and password', () async {
    // arrange
    when(() => mockUserRepository.loginUser(any(), any()))
        .thenAnswer((_) async => const Right(tToken));

    // act
    final result = await usecase(tParams);

    // assert
    expect(result, const Right(tToken));
    verify(() => mockUserRepository.loginUser(tEmail, tPassword)).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });

  test('should return Failure when repository fails to login', () async {
    // arrange
    const failure = RemoteDatabaseFailure(message: 'Login failed');
    when(() => mockUserRepository.loginUser(any(), any()))
        .thenAnswer((_) async => const Left(failure));

    // act
    final result = await usecase(tParams);

    // assert
    expect(result, const Left(failure));
    verify(() => mockUserRepository.loginUser(tEmail, tPassword)).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });
}
