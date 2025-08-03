// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   testWidgets('lesson view ...', (tester) async {
//     // TODO: Implement test
//   });
// }

// test/widget/lesson_view_test.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:batch34_b/features/lesson/presentation/view/lesson_view.dart';
// import 'package:batch34_b/features/lesson/presentation/view_model/lesson_view_model.dart';
// import 'package:batch34_b/features/lesson/presentation/view_model/lesson_state.dart';
// import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
// import 'package:mocktail/mocktail.dart';

// class MockLessonBloc extends Mock implements LessonBloc {}

// void main() {
//   late MockLessonBloc mockBloc;

//   setUp(() {
//     mockBloc = MockLessonBloc();
//   });

//   Widget createWidgetUnderTest() {
//     return MaterialApp(
//       home: BlocProvider<LessonBloc>.value(
//         value: mockBloc,
//         child: const LessonView(),
//       ),
//     );
//   }

//   testWidgets('shows loading indicator when loading', (tester) async {
//     when(() => mockBloc.state).thenReturn(const LessonLoadingState());

//     await tester.pumpWidget(createWidgetUnderTest());
//     expect(find.byType(CircularProgressIndicator), findsOneWidget);
//   });

//   testWidgets('shows error message on error', (tester) async {
//     when(
//       () => mockBloc.state,
//     ).thenReturn(const LessonErrorState(message: 'Error loading'));

//     await tester.pumpWidget(createWidgetUnderTest());
//     expect(find.text('Oops! Something went wrong'), findsOneWidget);
//     expect(find.text('Error loading'), findsOneWidget);
//   });

//   testWidgets('shows lesson list when loaded', (tester) async {
//     final lesson = LessonEntity(
//       id: '1',
//       name: 'Test Lesson',
//       description: 'desc',
//       authorName: 'author',
//       duration: '10 min',
//       price: 10.0,
//       createdAt: DateTime.now(),
//       updatedAt: DateTime.now(),
//     );

//     when(() => mockBloc.state).thenReturn(
//       LessonLoadedState(
//         lessons: [lesson],
//         pagination: LessonPagination.empty(),
//         hasReachedMax: true,
//         searchQuery: null,
//       ),
//     );

//     await tester.pumpWidget(createWidgetUnderTest());
//     expect(find.text('Test Lesson'), findsOneWidget);
//   });
// }
