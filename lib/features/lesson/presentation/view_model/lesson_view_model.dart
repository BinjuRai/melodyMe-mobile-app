import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:batch34_b/features/lesson/domain/usecase/get_all_lesson_usecase.dart';
import 'package:batch34_b/features/lesson/domain/repository/lesson_repository.dart';
import 'package:batch34_b/features/lesson/presentation/view_model/lesson_event.dart';
import 'package:batch34_b/features/lesson/presentation/view_model/lesson_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final GetAllLessonsUseCase _getAllLessonsUseCase;
  final LessonRepository _lessonRepository;

  // Internal state management
  List<LessonEntity> _lessons = [];
  LessonPagination? _currentPagination;
  String? _currentSearchQuery;
  static const int _allLessonsLimit = 1000; // large number to load all lessons

  LessonBloc({
    required GetAllLessonsUseCase getAllLessonsUseCase,
    required LessonRepository lessonRepository,
  }) : _getAllLessonsUseCase = getAllLessonsUseCase,
       _lessonRepository = lessonRepository,
       super(const LessonInitialState()) {
    on<LoadLessonsEvent>(_onLoadLessons);
    on<SearchLessonsEvent>(_onSearchLessons);
    on<RefreshLessonsEvent>(_onRefreshLessons);
    on<LoadLessonByIdEvent>(_onLoadLessonById);
    on<ClearLessonSearchEvent>(_onClearLessonSearch);
  }

  Future<void> _onLoadLessons(
    LoadLessonsEvent event,
    Emitter<LessonState> emit,
  ) async {
    print(
      '🔄 Loading lessons - Page: ${event.page}, Limit: ${event.limit}, Search: ${event.search}',
    );

    if (event.isRefresh && state is LessonLoadedState) {
      final currentState = state as LessonLoadedState;
      emit(
        LessonRefreshingState(
          lessons: currentState.lessons,
          pagination: currentState.pagination,
        ),
      );
    } else {
      emit(const LessonLoadingState());
    }

    _currentSearchQuery = event.search;

    // Fetch all lessons with a large limit, ignore event.page or set to 1 always
    final result = await _getAllLessonsUseCase.call(
      page: 1,
      limit: event.limit ?? _allLessonsLimit,
      search: event.search,
    );

    result.fold(
      (failure) {
        print('❌ Error loading lessons: ${failure.message}');
        emit(LessonErrorState(message: failure.message));
      },
      (lessonResponse) {
        print('✅ Successfully loaded ${lessonResponse.lessons.length} lessons');
        print(
          '📊 Pagination: ${lessonResponse.pagination.currentPage}/${lessonResponse.pagination.totalPages}',
        );

        _lessons = lessonResponse.lessons;
        _currentPagination = lessonResponse.pagination;

        // Debug: Print first few lesson names
        for (int i = 0; i < lessonResponse.lessons.length && i < 3; i++) {
          print('📚 Lesson ${i + 1}: ${lessonResponse.lessons[i].name}');
        }

        emit(
          LessonLoadedState(
            lessons: _lessons,
            pagination: lessonResponse.pagination,
            hasReachedMax: true, // No more pages, all lessons loaded
            searchQuery: event.search,
          ),
        );
      },
    );
  }

  Future<void> _onSearchLessons(
    SearchLessonsEvent event,
    Emitter<LessonState> emit,
  ) async {
    print('🔍 Searching lessons with query: "${event.query}"');
    emit(const LessonLoadingState());

    _currentSearchQuery = event.query.isEmpty ? null : event.query;

    final result = await _getAllLessonsUseCase.call(
      page: 1,
      limit: _allLessonsLimit, // fetch all matching lessons at once
      search: _currentSearchQuery,
    );

    result.fold(
      (failure) {
        print('❌ Error searching lessons: ${failure.message}');
        emit(LessonErrorState(message: failure.message));
      },
      (lessonResponse) {
        print(
          '✅ Search results: ${lessonResponse.lessons.length} lessons found',
        );
        _lessons = lessonResponse.lessons;
        _currentPagination = lessonResponse.pagination;

        emit(
          LessonLoadedState(
            lessons: _lessons,
            pagination: lessonResponse.pagination,
            hasReachedMax: true, // no more pages
            searchQuery: _currentSearchQuery,
          ),
        );
      },
    );
  }

  Future<void> _onRefreshLessons(
    RefreshLessonsEvent event,
    Emitter<LessonState> emit,
  ) async {
    print('🔄 Refreshing lessons');
    add(
      LoadLessonsEvent(
        page: 1,
        limit: _allLessonsLimit,
        search: _currentSearchQuery,
        isRefresh: true,
      ),
    );
  }

  Future<void> _onLoadLessonById(
    LoadLessonByIdEvent event,
    Emitter<LessonState> emit,
  ) async {
    print('🔍 Loading lesson by ID: ${event.lessonId}');
    emit(const LessonDetailLoadingState());

    final result = await _lessonRepository.getLessonById(event.lessonId);

    result.fold(
      (failure) {
        print('❌ Error loading lesson by ID: ${failure.message}');
        emit(LessonDetailErrorState(message: failure.message));
      },
      (lesson) {
        print('✅ Successfully loaded lesson: ${lesson.name}');
        emit(LessonDetailLoadedState(lesson: lesson));
      },
    );
  }

  Future<void> _onClearLessonSearch(
    ClearLessonSearchEvent event,
    Emitter<LessonState> emit,
  ) async {
    print('🧹 Clearing lesson search');
    add(const LoadLessonsEvent(page: 1, limit: _allLessonsLimit));
  }

  // Helper methods
  bool get hasReachedMax => true; // Always true since no pagination now

  List<LessonEntity> get currentLessons {
    if (state is LessonLoadedState) {
      return (state as LessonLoadedState).lessons;
    }
    return [];
  }

  String? get currentSearchQuery {
    if (state is LessonLoadedState) {
      return (state as LessonLoadedState).searchQuery;
    }
    return null;
  }
}
