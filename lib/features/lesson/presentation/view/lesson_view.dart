import 'package:batch34_b/features/lesson/domain/entity/lesson_entity.dart';
import 'package:batch34_b/features/lesson/presentation/view_model/lesson_event.dart';
import 'package:batch34_b/features/lesson/presentation/view_model/lesson_state.dart';
import 'package:batch34_b/features/lesson/presentation/view_model/lesson_view_model.dart';
import 'package:batch34_b/core/common/card/lesson_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonView extends StatefulWidget {
  const LessonView({super.key});

  @override
  State<LessonView> createState() => _LessonViewState();
}

class _LessonViewState extends State<LessonView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<LessonBloc>().add(const LoadLessonsEvent());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Lessons'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LessonSearchBar(
              controller: _searchController,
              onSearch: (query) {
                context.read<LessonBloc>().add(SearchLessonsEvent(query: query));
              },
              onClear: () {
                _searchController.clear();
                context.read<LessonBloc>().add(const ClearLessonSearchEvent());
              },
            ),
          ),
          Expanded(
            child: BlocBuilder<LessonBloc, LessonState>(
              builder: (context, state) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<LessonBloc>().add(const RefreshLessonsEvent());
                  },
                  child: _buildBody(state),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(LessonState state) {
    if (state is LessonLoadingState) {
      return const Center(child: LoadingWidget());
    }

    if (state is LessonErrorState) {
      return _buildErrorWidget(state.message);
    }

    if (state is LessonLoadedState) {
      final lessons = state.lessons;
      final isSearching = (state.searchQuery != null && state.searchQuery!.isNotEmpty);

      return _buildLessonsList(
        lessons: lessons,
        isSearching: isSearching,
        isRefreshing: false,
      );
    }

    if (state is LessonRefreshingState) {
      final lessons = state.lessons;
      final isSearching = (state.searchQuery != null && state.searchQuery!.isNotEmpty);

      return _buildLessonsList(
        lessons: lessons,
        isSearching: isSearching,
        isRefreshing: true,
      );
    }

    return const Center(child: Text('No lessons available'));
  }

  Widget _buildLessonsList({
    required List<LessonEntity> lessons,
    required bool isSearching,
    bool isRefreshing = false,
  }) {
    if (lessons.isEmpty) {
      return _buildEmptyWidget(isSearching);
    }

    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: LessonCard(
            lesson: lesson,
            onTap: () => _onLessonTap(lesson),
          ),
        );
      },
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
          const SizedBox(height: 16),
          Text(
            'Oops! Something went wrong',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.read<LessonBloc>().add(const LoadLessonsEvent());
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget(bool isSearching) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 64, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            isSearching ? 'No lessons match your search.' : 'No lessons available.',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            isSearching
                ? 'Try refining your search keywords.'
                : 'Check back later or try refreshing.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _onLessonTap(LessonEntity lesson) {
    // You can navigate to a detail page here
    debugPrint("Tapped on lesson: ${lesson.name}");
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(title));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class LessonSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSearch;
  final VoidCallback onClear;

  const LessonSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search lessons...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: onClear,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onSubmitted: onSearch,
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator();
  }
}
