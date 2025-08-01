// import 'package:batch34_b/features/course/domain/repository/course_repository.dart';
// import 'package:batch34_b/features/course/domain/usecase/get_lesson_by_courseId.dart';
// import 'package:batch34_b/features/course/presentation/view_model/course_detail_event.dart';
// import 'package:batch34_b/features/course/presentation/view_model/course_detail_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
//   final CourseRepository courseRepository;
//   final GetLessonsByCourseUseCase getLessonsByCourseUseCase;

//   CourseDetailBloc({
//     required this.courseRepository,
//     required this.getLessonsByCourseUseCase,
//   }) : super(CourseDetailInitial()) {
//     on<FetchCourseDetail>(_onFetch);
//   }

//   Future<void> _onFetch(FetchCourseDetail event, Emitter<CourseDetailState> emit) async {
//     emit(CourseDetailLoading());
//     try {
//       final courseResult = await courseRepository.getCourseById(event.courseId);
//       final lessonsResult = await courseRepository.getLessonsByCourse(event.courseId);

//       if (courseResult.isRight() && lessonsResult.isRight()) {
//         final course = courseResult.getOrElse(() => throw Exception("No course"));
//         final lessons = lessonsResult.getOrElse(() => []);
//         emit(CourseDetailLoaded(course.toEntity(), lessons));
//       } else {
//         emit(CourseDetailError("Failed to load course details"));
//       }
//     } catch (e) {
//       emit(CourseDetailError(e.toString()));
//     }
//   }

//   // Define this method **outside** of _onFetch, so it can be called externally
//   void loadCourseDetail(String courseId) {
//     add(FetchCourseDetail(courseId));
//   }
// }
import 'package:batch34_b/features/course/domain/repository/course_repository.dart';
import 'package:batch34_b/features/course/domain/usecase/get_lesson_by_courseId.dart';
import 'package:batch34_b/features/course/presentation/view_model/course_detail_event.dart';
import 'package:batch34_b/features/course/presentation/view_model/course_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailBloc extends Bloc<CourseDetailEvent, CourseDetailState> {
  final CourseRepository courseRepository;
  final GetLessonsByCourseUseCase getLessonsByCourseUseCase;

  CourseDetailBloc({
    required this.courseRepository,
    required this.getLessonsByCourseUseCase,
  }) : super(CourseDetailInitial()) {
    on<FetchCourseDetail>(_onFetch);
  }

  Future<void> _onFetch(
    FetchCourseDetail event,
    Emitter<CourseDetailState> emit,
  ) async {
    try {
      print(
        '🔍 BLoC: Starting to fetch course details for ID: ${event.courseId}',
      );
      print('🔍 BLoC: Course ID type: ${event.courseId.runtimeType}');

      emit(CourseDetailLoading());

      // Add null/empty check
      if (event.courseId.isEmpty) {
        print('❌ BLoC: Course ID is empty');
        emit(CourseDetailError("Course ID cannot be empty"));
        return;
      }

      print('🔍 BLoC: Fetching course by ID...');
      final courseResult = await courseRepository.getCourseById(event.courseId);

      print('🔍 BLoC: Course result received: ${courseResult.isRight()}');

      print('🔍 BLoC: Fetching lessons by course ID...');
      final lessonsResult = await courseRepository.getLessonsByCourse(
        event.courseId,
      );

      print('🔍 BLoC: Lessons result received: ${lessonsResult.isRight()}');

      // Handle results with better error checking
      courseResult.fold(
        (courseFailure) {
          print('❌ BLoC: Course fetch failed: ${courseFailure.message}');
          emit(
            CourseDetailError(
              "Failed to load course: ${courseFailure.message}",
            ),
          );
        },
        (course) {
          print('✅ BLoC: Course loaded successfully: ${course.name}');

          lessonsResult.fold(
            (lessonsFailure) {
              print('❌ BLoC: Lessons fetch failed: ${lessonsFailure.message}');
              // Still show course even if lessons fail
              emit(CourseDetailLoaded(course.toEntity(), []));
            },
            (lessons) {
              print(
                '✅ BLoC: Lessons loaded successfully: ${lessons.length} lessons',
              );

              // Debug lesson data before processing
              for (int i = 0; i < lessons.length; i++) {
                print('🔍 BLoC: Lesson $i: ${lessons[i]}');
              }

              try {
                // This is where the String/int error might occur
                print('🔍 BLoC: Converting course to entity...');
                final courseEntity = course.toEntity();
                print('✅ BLoC: Course entity created successfully');

                print('🔍 BLoC: Emitting CourseDetailLoaded state...');
                emit(CourseDetailLoaded(courseEntity, lessons));
                print('✅ BLoC: State emitted successfully');
              } catch (e, stackTrace) {
                print(
                  '❌ BLoC: Error during entity conversion or state emission: $e',
                );
                print('📍 BLoC: Stack trace: $stackTrace');
                emit(CourseDetailError("Error processing course data: $e"));
              }
            },
          );
        },
      );
    } catch (e, stackTrace) {
      print('❌ BLoC: Unexpected error in _onFetch: $e');
      print('📍 BLoC: Full stack trace: $stackTrace');
      emit(CourseDetailError("Unexpected error: $e"));
    }
  }

  // Define this method **outside** of _onFetch, so it can be called externally
  void loadCourseDetail(String courseId) {
    print('🔍 BLoC: loadCourseDetail called with courseId: $courseId');
    add(FetchCourseDetail(courseId));
  }
}
