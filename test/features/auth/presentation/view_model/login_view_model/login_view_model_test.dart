// import 'package:bloc_test/bloc_test.dart';
// import 'package:dartz/dartz.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:batch34_b/core/error/failure.dart';
// import 'package:batch34_b/features/auth/domain/use_case/user_login_usecase.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_event.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_state.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';

// class MockUserLoginUsecase extends Mock implements UserLoginUsecase {}

// class MockBuildContext extends Mock implements BuildContext {}

// void main() {
//   late UserLoginUsecase userLoginUsecase;
//   late LoginViewModel loginViewModel;

//   setUp(() {
//     userLoginUsecase = MockUserLoginUsecase();

//     // Register fallback values for mocktail
//     registerFallbackValue(const LoginParams(email: '', password: ''));
//   });

//   group('LoginViewModel', () {
//     const email = 'test@example.com';
//     const password = 'password123';
//     const token = 'mock_token';

//     setUp(() {
//       loginViewModel = LoginViewModel(userLoginUsecase);
//     });

//     tearDown(() {
//       loginViewModel.close();
//     });

//     testWidgets('emits success state when login succeeds', (tester) async {
//       // Arrange
//       when(
//         () => userLoginUsecase.call(any()),
//       ).thenAnswer((_) async => const Right(token));

//       BuildContext? testContext;

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: Builder(
//               builder: (context) {
//                 testContext = context;
//                 return const SizedBox();
//               },
//             ),
//           ),
//         ),
//       );

//       // Act
//       loginViewModel.add(
//         LoginWithEmailAndPasswordEvent(
//           email: email,
//           password: password,
//           context: testContext!,
//         ),
//       );

//       await tester.pumpAndSettle();

//       // Assert
//       expect(loginViewModel.state.isLoading, false);
//       expect(loginViewModel.state.isSuccess, true);
//       verify(
//         () => userLoginUsecase.call(
//           const LoginParams(email: email, password: password),
//         ),
//       ).called(1);
//     });

//     testWidgets('emits failure state when login fails', (tester) async {
//       // Arrange
//       when(() => userLoginUsecase.call(any())).thenAnswer(
//         (_) async =>
//             Left(RemoteDatabaseFailure(message: 'Invalid credentials')),
//       );

//       BuildContext? testContext;

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: Builder(
//               builder: (context) {
//                 testContext = context;
//                 return const SizedBox();
//               },
//             ),
//           ),
//         ),
//       );

//       // Act
//       loginViewModel.add(
//         LoginWithEmailAndPasswordEvent(
//           email: email,
//           password: password,
//           context: testContext!,
//         ),
//       );

//       await tester.pumpAndSettle();

//       // Assert
//       expect(loginViewModel.state.isLoading, false);
//       expect(loginViewModel.state.isSuccess, false);
//       verify(
//         () => userLoginUsecase.call(
//           const LoginParams(email: email, password: password),
//         ),
//       ).called(1);
//     });

//     testWidgets('handles server failure', (tester) async {
//       // Arrange
//       when(() => userLoginUsecase.call(any())).thenAnswer(
//         (_) async => Left(RemoteDatabaseFailure(message: 'Server error')),
//       );

//       BuildContext? testContext;

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: Builder(
//               builder: (context) {
//                 testContext = context;
//                 return const SizedBox();
//               },
//             ),
//           ),
//         ),
//       );

//       // Act
//       loginViewModel.add(
//         LoginWithEmailAndPasswordEvent(
//           email: email,
//           password: password,
//           context: testContext!,
//         ),
//       );

//       await tester.pumpAndSettle();

//       // Assert
//       expect(loginViewModel.state.isLoading, false);
//       expect(loginViewModel.state.isSuccess, false);
//       verify(
//         () => userLoginUsecase.call(
//           const LoginParams(email: email, password: password),
//         ),
//       ).called(1);
//     });

//     testWidgets('handles navigation to register view event', (tester) async {
//       // Create a real BuildContext for the navigation test
//       BuildContext? testContext;

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: Builder(
//               builder: (context) {
//                 testContext = context;
//                 return const SizedBox();
//               },
//             ),
//           ),
//         ),
//       );

//       // Since navigation doesn't change state and has complex dependencies,
//       // we just verify the event can be added without errors
//       expect(
//         () => loginViewModel.add(
//           NavigateToRegisterViewEvent(context: testContext!),
//         ),
//         returnsNormally,
//       );

//       // Navigation events don't change state
//       expect(loginViewModel.state, LoginState.initial());
//     });

//     test('initial state is correct', () {
//       expect(loginViewModel.state, LoginState.initial());
//     });

//     test('state has correct initial values', () {
//       final initialState = LoginState.initial();
//       expect(initialState.isLoading, false);
//       expect(initialState.isSuccess, false);
//     });
//   });
// }
