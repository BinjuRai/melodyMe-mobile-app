// import 'package:batch34_b/app/share_pref/token_shared_pref.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:dartz/dartz.dart';
// import 'package:batch34_b/features/auth/domain/use_case/user_login_usecase.dart';
// import 'package:batch34_b/features/auth/domain/use_case/user_login_usecase.dart'
//     show LoginParams;
// import 'package:batch34_b/features/auth/presentation/view/login_view.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';
// import 'package:batch34_b/core/error/failure.dart';

// import '../features/auth/domain/use_case/token.mock.dart';

// class MockUserLoginUsecase extends Mock implements UserLoginUsecase {}

// class FakeLoginParams extends Fake implements LoginParams {}

// final sl = GetIt.instance;

// void main() {
//   late MockUserLoginUsecase mockUserLoginUsecase;

//   setUpAll(() {
//     registerFallbackValue(FakeLoginParams());
//   });

//   setUp(() {
//     mockUserLoginUsecase = MockUserLoginUsecase();
//   });

//   Widget buildLoginScreen() {
//     return MaterialApp(
//       home: BlocProvider(
//         create: (_) => LoginViewModel(mockUserLoginUsecase),
//         child: LoginView(),
//       ),
//     );
//   }

//   testWidgets('LoginView should have email, password fields and login button', (
//     tester,
//   ) async {
//     await tester.pumpWidget(buildLoginScreen());

//     expect(find.byType(TextField), findsNWidgets(2));
//     expect(find.text('Login'), findsOneWidget);
//   });

//   testWidgets('shows error snackbar on failed login', (tester) async {
//     when(() => mockUserLoginUsecase(any())).thenAnswer(
//       (_) async => const Left(RemoteDatabaseFailure(message: 'Login failed')),
//     );

//     await tester.pumpWidget(buildLoginScreen());

//     await tester.enterText(find.byType(TextField).at(0), 'test@email.com');
//     await tester.enterText(find.byType(TextField).at(1), 'wrongpassword');

//     await tester.tap(find.text('Login'));
//     await tester.pumpAndSettle();

//     expect(find.text('Invalid credentials. Please try again.'), findsOneWidget);
//   });

//   testWidgets('navigates to dashboard on successful login', (tester) async {
//     when(
//       () => mockUserLoginUsecase(any()),
//     ).thenAnswer((_) async => const Right('token_123'));

//     await tester.pumpWidget(buildLoginScreen());

//     await tester.enterText(find.byType(TextField).at(0), 'test@email.com');
//     await tester.enterText(find.byType(TextField).at(1), 'correctpassword');

//     await tester.tap(find.text('Login'));
//     await tester.pumpAndSettle();

//     // You'll need a specific widget or screen title from Dashboard to assert
//     expect(
//       find.byType(Scaffold),
//       findsWidgets,
//     ); // or look for a specific dashboard text
//   });
//   testWidgets('navigates to dashboard on successful login', (tester) async {
//     final mockTokenSharedPrefs = MockTokenSharedPrefs();
//     sl.registerLazySingleton<TokenSharedPrefs>(() => mockTokenSharedPrefs);

//     when(
//       () => mockUserLoginUsecase(any()),
//     ).thenAnswer((_) async => const Right('token_123'));

//     await tester.pumpWidget(buildLoginScreen());

//     await tester.enterText(find.byType(TextField).at(0), 'test@email.com');
//     await tester.enterText(find.byType(TextField).at(1), 'correctpassword');

//     await tester.tap(find.text('Login'));
//     await tester.pumpAndSettle();

//     // Check that the user navigated to dashboard or home screen
//     expect(
//       find.text('Dashboard'),
//       findsOneWidget,
//     ); // replace with an actual widget/text on dashboard
//   });
//   testWidgets('LoginView shows email, password fields and login button', (tester) async {
//   await tester.pumpWidget(buildLoginScreen());
//   await tester.pumpAndSettle();

//   // Debug: print all Texts
//   final allTextWidgets = find.byType(Text);
//   for (var e in allTextWidgets.evaluate()) {
//     final textWidget = e.widget as Text;
//     print('Found Text: "${textWidget.data}"');
//   }

//   expect(find.byType(TextField), findsNWidgets(2));

//   // Safe version using Key or just text match
//   final loginButton = find.byKey(const Key('loginButton')); // preferred
//   expect(loginButton, findsOneWidget);

//   await tester.tap(loginButton);
// });

// }

// }
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:dartz/dartz.dart';

// import 'package:batch34_b/features/auth/domain/use_case/user_login_usecase.dart';
// import 'package:batch34_b/features/auth/presentation/view/login_view.dart';
// import 'package:batch34_b/features/auth/presentation/view_model/login_view_model/login_view_model.dart';

// class MockUserLoginUsecase extends Mock implements UserLoginUsecase {}

// class FakeLoginParams extends Fake implements LoginParams {}

// void main() {
//   late MockUserLoginUsecase mockUserLoginUsecase;

//   setUpAll(() {
//     registerFallbackValue(FakeLoginParams());
//   });

//   setUp(() {
//     mockUserLoginUsecase = MockUserLoginUsecase();
//   });

//   Widget buildLoginScreen() {
//     return MaterialApp(
//       home: BlocProvider(
//         create: (_) => LoginViewModel(mockUserLoginUsecase),
//         child: LoginView(),
//       ),
//     );
//   }

//   testWidgets('LoginView shows email, password fields and Login button', (tester) async {
//     await tester.pumpWidget(buildLoginScreen());
//     await tester.pump(); // let widget build finish

//     // Expect 2 text fields
//     expect(find.byType(TextField), findsNWidgets(2));

//     // ✅ Use text only (less strict than widgetWithText)
//     expect(find.text('Login'), findsOneWidget);
//   });

//   testWidgets('successful login navigates to dashboard', (tester) async {
//     when(() => mockUserLoginUsecase(any())).thenAnswer(
//       (_) async => const Right('fake_token'),
//     );

//     await tester.pumpWidget(MaterialApp(
//       home: BlocProvider(
//         create: (_) => LoginViewModel(mockUserLoginUsecase),
//         child: LoginView(),
//       ),
//       routes: {
//         '/dashboard': (_) => const Scaffold(body: Text('Dashboard')),
//       },
//     ));

//     await tester.pumpAndSettle();

//     // Enter credentials
//     await tester.enterText(find.byType(TextField).at(0), 'user@email.com');
//     await tester.enterText(find.byType(TextField).at(1), 'password123');

//     // Find and tap Login button (use text instead of strict type match)
//     final loginButton = find.text('Login');
//     expect(loginButton, findsOneWidget);
//     await tester.tap(loginButton);

//     await tester.pumpAndSettle();

//     expect(find.text('Dashboard'), findsOneWidget);
//   });
//   testWidgets('LoginView shows email, password fields and Login button', (tester) async {
//   await tester.pumpWidget(buildLoginScreen());
//   await tester.pumpAndSettle(); // Ensure widget builds fully

//   expect(find.byType(TextField), findsNWidgets(2));

//   // ✅ Safely match the login button
//   final loginTextFinder = find.text('Login');
//   expect(loginTextFinder, findsOneWidget); // Fails if not found

//   // Optional: check widget type
//   final loginButtonFinder = find.ancestor(
//     of: loginTextFinder,
//     matching: find.byType(ElevatedButton),
//   );
//   expect(loginButtonFinder, findsOneWidget);
// });

// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

import 'package:batch34_b/features/auth/domain/use_case/user_login_usecase.dart';
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

  testWidgets('renders two input fields and login button', (tester) async {
    await tester.pumpWidget(buildLoginScreen());
    await tester.pumpAndSettle();

    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('🎧 Login'), findsOneWidget);
  });

  testWidgets('shows error snackbar on failed login', (tester) async {
    when(() => mockUserLoginUsecase(any())).thenAnswer(
      (_) async => const Left(RemoteDatabaseFailure(message: 'Login failed')),
    );

    await tester.pumpWidget(buildLoginScreen());
    await tester.enterText(
      find.byType(TextFormField).at(0),
      'user@example.com',
    );
    await tester.enterText(find.byType(TextFormField).at(1), 'wrongpass');

    await tester.tap(find.text('🎧 Login'));
    await tester.pumpAndSettle();

    expect(find.text('Invalid credentials. Please try again.'), findsOneWidget);
  });
}
