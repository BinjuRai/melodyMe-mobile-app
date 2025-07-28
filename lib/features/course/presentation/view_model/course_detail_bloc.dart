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

  Future<void> _onFetch(FetchCourseDetail event, Emitter<CourseDetailState> emit) async {
    emit(CourseDetailLoading());
    try {
      final courseResult = await courseRepository.getCourseById(event.courseId);
      final lessonsResult = await courseRepository.getLessonsByCourse(event.courseId);

      if (courseResult.isRight() && lessonsResult.isRight()) {
        final course = courseResult.getOrElse(() => throw Exception("No course"));
        final lessons = lessonsResult.getOrElse(() => []);
        emit(CourseDetailLoaded(course.toEntity(), lessons));
      } else {
        emit(CourseDetailError("Failed to load course details"));
      }
    } catch (e) {
      emit(CourseDetailError(e.toString()));
    }
  }

  // Define this method **outside** of _onFetch, so it can be called externally
  void loadCourseDetail(String courseId) {
    add(FetchCourseDetail(courseId));
  }
}
