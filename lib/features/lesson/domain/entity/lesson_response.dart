// import 'package:equatable/equatable.dart';
// import 'lesson_entity.dart';

// class LessonResponse extends Equatable {
//   final List<LessonEntity> lessons;
//   final Pagination pagination;

//   const LessonResponse({
//     required this.lessons,
//     required this.pagination,
//   });

//   @override
//   List<Object?> get props => [lessons, pagination];
// }

// class Pagination extends Equatable {
//   final int currentPage;
//   final int totalPages;
//   final int totalItems;

//   const Pagination({
//     required this.currentPage,
//     required this.totalPages,
//     required this.totalItems,
//   });

//   @override
//   List<Object?> get props => [currentPage, totalPages, totalItems];
// }

import 'package:equatable/equatable.dart';
import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';

class LessonResponse extends Equatable {
  final List<LessonEntity> lessons;
  final LessonPagination pagination;

  const LessonResponse({
    required this.lessons,
    required this.pagination,
  });

  factory LessonResponse.empty() {
    return LessonResponse(
      lessons: const [],
      pagination: LessonPagination.empty(),
    );
  }

  @override
  List<Object> get props => [lessons, pagination];
}