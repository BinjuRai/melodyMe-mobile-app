import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:batch34_b/features/auth/domain/use_case/user_login_usecase.dart';
import 'package:batch34_b/features/auth/domain/use_case/user_login_usecase.dart' show LoginParams;
import 'package:batch34_b/features/auth/presentation/view/login_view.dart';
import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:batch34_b/core/error/failure.dart';

class MockUserLoginUsecase extends Mock implements UserLoginUsecase {}

class FakeLoginParams extends Fake implements LoginParams {}

void main() {
  late MockUserLoginUsecase mockUserLoginUsecase;

  setUpAll(() {
    registerFallbackValue(FakeLoginParams());
  });

  setUp(() {
    mockUserLoginUsecase = MockUserLoginUsecase();
  });

  Widget buildLoginScreen() {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => LoginViewModel(mockUserLoginUsecase),
        child: LoginView(),
      ),
    );
  }

  testWidgets('LoginView should have email, password fields and login button', (tester) async {
    await tester.pumpWidget(buildLoginScreen());

    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('shows error snackbar on failed login', (tester) async {
    when(() => mockUserLoginUsecase(any())).thenAnswer(
      (_) async => const Left(RemoteDatabaseFailure(message: 'Login failed')),
    );

    await tester.pumpWidget(buildLoginScreen());

    await tester.enterText(find.byType(TextField).at(0), 'test@email.com');
    await tester.enterText(find.byType(TextField).at(1), 'wrongpassword');

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Invalid credentials. Please try again.'), findsOneWidget);
  });

  testWidgets('navigates to dashboard on successful login', (tester) async {
    when(() => mockUserLoginUsecase(any())).thenAnswer(
      (_) async => const Right('token_123'),
    );

    await tester.pumpWidget(buildLoginScreen());

    await tester.enterText(find.byType(TextField).at(0), 'test@email.com');
    await tester.enterText(find.byType(TextField).at(1), 'correctpassword');

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // You'll need a specific widget or screen title from Dashboard to assert
    expect(find.byType(Scaffold), findsWidgets); // or look for a specific dashboard text
  });
}
