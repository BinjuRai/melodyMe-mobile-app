import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:batch34_b/features/course/presentation/view_model/course_view_model.dart';
import 'package:batch34_b/features/course/presentation/view_model/course_event.dart';
import 'package:batch34_b/features/course/presentation/view_model/course_state.dart';

class CourseListPage extends StatefulWidget {
  const CourseListPage({Key? key}) : super(key: key);

  @override
  State<CourseListPage> createState() => _CourseListPageState();
}

class _CourseListPageState extends State<CourseListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CourseBloc>().add(FetchCourses());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300) {
        final state = context.read<CourseBloc>().state;
        if (state is CourseLoaded && state.hasMore) {
          context.read<CourseBloc>().add(FetchCourses(page: state.currentPage + 1));
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Always dispose controllers
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
      ),
      body: BlocBuilder<CourseBloc, CourseState>(
        builder: (context, state) {
          if (state is CourseLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CourseLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.courses.length + (state.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == state.courses.length) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final course = state.courses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(course.name),
                    subtitle: Text('ID: ${course.id}'),
                    leading: const Icon(Icons.book),
                    onTap: () {
                      // Handle tap
                    },
                  ),
                );
              },
            );
          }

          if (state is CourseError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
