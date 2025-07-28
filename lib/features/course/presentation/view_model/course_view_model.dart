import 'package:batch34_b/features/course/domain/entity/course_entity.dart';
import 'package:batch34_b/features/course/domain/usecase/get_all_courses.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'course_event.dart';
import 'course_state.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  final GetAllCourses getAllCourses;

  List<CourseEntity> _courses = []; // Changed to CourseEntity
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isFetching = false;

  CourseBloc({required this.getAllCourses}) : super(CourseInitial()) {
    on<FetchCourses>(_onFetchCourses);
  }

  Future<void> _onFetchCourses(
    FetchCourses event,
    Emitter<CourseState> emit,
  ) async {
    if (_isFetching || !_hasMore) return;

    _isFetching = true;
    emit(CourseLoading());

    final result = await getAllCourses();

    result.fold((failure) => emit(CourseError(failure.message)), (data) {
      // Assuming page size 10 for pagination logic
      _hasMore = data.length == 10;
      _currentPage = event.page;

      if (event.page == 1) {
        _courses = data;
      } else {
        _courses.addAll(data);
      }

      emit(CourseLoaded(_courses, _currentPage, _hasMore));
    });

    _isFetching = false;
  }
}

