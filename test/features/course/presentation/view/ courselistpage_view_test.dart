import 'package:batch34_b/core/common/card/course_card.dart';
import 'package:batch34_b/features/course/domain/entity/course_entity.dart';
import 'package:batch34_b/features/course/presentation/view/%20courselistpage_view.dart';
import 'package:batch34_b/features/course/presentation/view_model/course_state.dart';
import 'package:batch34_b/features/course/presentation/view_model/course_view_model.dart';
import 'package:batch34_b/features/course/presentation/view_model/course_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCourseBloc extends Mock implements CourseBloc {}

class FakeCourseEvent extends Fake implements CourseEvent {}

class FakeCourseState extends Fake implements CourseState {}

void main() {
  late MockCourseBloc mockCourseBloc;

  final testCourses = [
    CourseEntity(id: 'c1', name: 'Course 1', totalPrice: 100),
    CourseEntity(id: 'c2', name: 'Course 2', totalPrice: 200),
  ];

  setUpAll(() {
    registerFallbackValue(FakeCourseEvent());
    registerFallbackValue(FakeCourseState());
  });

  setUp(() {
    mockCourseBloc = MockCourseBloc();

    // Default stub for stream to avoid null errors
    when(
      () => mockCourseBloc.stream,
    ).thenAnswer((_) => const Stream<CourseState>.empty());
  });

  // Helper to stub bloc state & stream together
  void stubBlocState(CourseState state) {
    when(() => mockCourseBloc.state).thenReturn(state);
    when(
      () => mockCourseBloc.stream,
    ).thenAnswer((_) => Stream<CourseState>.fromIterable([state]));
  }

  Widget makeTestableWidget() {
    return MaterialApp(
      home: BlocProvider<CourseBloc>.value(
        value: mockCourseBloc,
        child: const CourseListPage(),
      ),
    );
  }

  testWidgets('shows loading spinner when state is CourseLoading', (
    tester,
  ) async {
    stubBlocState(CourseLoading());

    await tester.pumpWidget(makeTestableWidget());
    await tester.pump(); // Let the widget build

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
  testWidgets('shows list of courses when state is CourseLoaded', (
    tester,
  ) async {
    stubBlocState(CourseLoaded(testCourses, 1, true));

    await tester.pumpWidget(makeTestableWidget());
    await tester.pump(); // instead of pumpAndSettle

    // If you want to simulate a frame delay, you can do:
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.byType(CourseCard), findsNWidgets(testCourses.length));
    expect(find.text('Course 1'), findsOneWidget);
    expect(find.text('Course 2'), findsOneWidget);
  });
 


  testWidgets('shows loading indicator at list bottom when hasMore is true', (
    tester,
  ) async {
    stubBlocState(CourseLoaded(testCourses, 1, true));

    await tester.pumpWidget(makeTestableWidget());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    // Course cards + 1 loading spinner at bottom
    expect(find.byType(CourseCard), findsNWidgets(testCourses.length));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error message when state is CourseError', (tester) async {
    const errorMessage = 'Failed to load courses';

    stubBlocState(CourseError(errorMessage));

    await tester.pumpWidget(makeTestableWidget());
    await tester.pumpAndSettle();

    expect(find.text(errorMessage), findsOneWidget);
  });
  testWidgets('fetches next page when scrolled near bottom', (tester) async {
    stubBlocState(CourseLoaded(testCourses, 1, true));

    when(() => mockCourseBloc.add(any())).thenReturn(null);

    await tester.pumpWidget(makeTestableWidget());
    await tester.pump(); // first frame
    await tester.pump(const Duration(milliseconds: 500)); // wait for build

    final listFinder = find.byType(ListView);
    expect(listFinder, findsOneWidget);

    // Scroll near bottom to trigger pagination event
    await tester.drag(listFinder, const Offset(0, -500));
    await tester.pump(); // animate scroll
    await tester.pump(const Duration(milliseconds: 500)); // allow bloc to react

    verify(() => mockCourseBloc.add(FetchCourses(page: 2))).called(1);
  });
}
