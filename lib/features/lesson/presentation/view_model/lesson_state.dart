// import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
// import 'package:equatable/equatable.dart';

// abstract class LessonState extends Equatable {
//   const LessonState();

//   @override
//   List<Object?> get props => [];
// }

// class LessonInitialState extends LessonState {
//   const LessonInitialState();
// }

// class LessonLoadingState extends LessonState {
//   const LessonLoadingState();
// }

// class LessonLoadedState extends LessonState {
//   final List<LessonEntity> lessons;
//   final LessonPagination pagination;
//   final bool hasReachedMax;
//   final String? searchQuery;

//   const LessonLoadedState({
//     required this.lessons,
//     required this.pagination,
//     this.hasReachedMax = false,
//     this.searchQuery,
//   });

//   @override
//   List<Object?> get props => [lessons, pagination, hasReachedMax, searchQuery];

//   LessonLoadedState copyWith({
//     List<LessonEntity>? lessons,
//     LessonPagination? pagination,
//     bool? hasReachedMax,
//     String? searchQuery,
//   }) {
//     return LessonLoadedState(
//       lessons: lessons ?? this.lessons,
//       pagination: pagination ?? this.pagination,
//       hasReachedMax: hasReachedMax ?? this.hasReachedMax,
//       searchQuery: searchQuery ?? this.searchQuery,
//     );
//   }
// }

// class LessonLoadMoreState extends LessonState {
//   final List<LessonEntity> lessons;
//   final LessonPagination pagination;
//   final String? searchQuery;

//   const LessonLoadMoreState({
//     required this.lessons,
//     required this.pagination,
//     this.searchQuery,
//   });

//   @override
//   List<Object?> get props => [lessons, pagination, searchQuery];
// }

// class LessonErrorState extends LessonState {
//   final String message;

//   const LessonErrorState({required this.message});

//   @override
//   List<Object?> get props => [message];
// }

// class LessonRefreshingState extends LessonState {
//   final List<LessonEntity> lessons;
//   final LessonPagination pagination;

//   const LessonRefreshingState({
//     required this.lessons,
//     required this.pagination,
//   });

//   @override
//   List<Object?> get props => [lessons, pagination];
// }

// // States for individual lesson detail
// class LessonDetailLoadingState extends LessonState {
//   const LessonDetailLoadingState();
// }

// class LessonDetailLoadedState extends LessonState {
//   final LessonEntity lesson;

//   const LessonDetailLoadedState({required this.lesson});

//   @override
//   List<Object?> get props => [lesson];
// }

// class LessonDetailErrorState extends LessonState {
//   final String message;

//   const LessonDetailErrorState({required this.message});

//   @override
//   List<Object?> get props => [message];
// }

import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:equatable/equatable.dart';

abstract class LessonState extends Equatable {
  const LessonState();

  @override
  List<Object?> get props => [];
}

class LessonInitialState extends LessonState {
  const LessonInitialState();
}

class LessonLoadingState extends LessonState {
  const LessonLoadingState();
}

class LessonLoadedState extends LessonState {
  final List<LessonEntity> lessons;
  final LessonPagination pagination;
  final bool hasReachedMax;
  final String? searchQuery;

  const LessonLoadedState({
    required this.lessons,
    required this.pagination,
    this.hasReachedMax = false,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [lessons, pagination, hasReachedMax, searchQuery];

  LessonLoadedState copyWith({
    List<LessonEntity>? lessons,
    LessonPagination? pagination,
    bool? hasReachedMax,
    String? searchQuery,
  }) {
    return LessonLoadedState(
      lessons: lessons ?? this.lessons,
      pagination: pagination ?? this.pagination,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class LessonLoadMoreState extends LessonState {
  final List<LessonEntity> lessons;
  final LessonPagination pagination;
  final String? searchQuery;

  const LessonLoadMoreState({
    required this.lessons,
    required this.pagination,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [lessons, pagination, searchQuery];
}

class LessonErrorState extends LessonState {
  final String message;

  const LessonErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class LessonRefreshingState extends LessonState {
  final List<LessonEntity> lessons;
  final LessonPagination pagination;
  final String? searchQuery;  // <-- Added this!

  const LessonRefreshingState({
    required this.lessons,
    required this.pagination,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [lessons, pagination, searchQuery];
}

// States for individual lesson detail
class LessonDetailLoadingState extends LessonState {
  const LessonDetailLoadingState();
}

class LessonDetailLoadedState extends LessonState {
  final LessonEntity lesson;

  const LessonDetailLoadedState({required this.lesson});

  @override
  List<Object?> get props => [lesson];
}

class LessonDetailErrorState extends LessonState {
  final String message;

  const LessonDetailErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
