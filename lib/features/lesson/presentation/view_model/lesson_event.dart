import 'package:equatable/equatable.dart';

abstract class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object?> get props => [];
}

class LoadLessonsEvent extends LessonEvent {
  final int page;
  final int? limit;
  final String? search;
  final bool isRefresh;

  const LoadLessonsEvent({
    this.page = 1,
    this.limit,
    this.search,
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [page, limit, search, isRefresh];
}

class LoadMoreLessonsEvent extends LessonEvent {
  const LoadMoreLessonsEvent();
}

class SearchLessonsEvent extends LessonEvent {
  final String query;

  const SearchLessonsEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

class RefreshLessonsEvent extends LessonEvent {
  const RefreshLessonsEvent();
}

class LoadLessonByIdEvent extends LessonEvent {
  final String lessonId;

  const LoadLessonByIdEvent({required this.lessonId});

  @override
  List<Object?> get props => [lessonId];
}

class ClearLessonSearchEvent extends LessonEvent {
  const ClearLessonSearchEvent();
}