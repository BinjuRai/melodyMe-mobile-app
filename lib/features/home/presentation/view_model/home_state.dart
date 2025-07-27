import 'package:batch34_b/bottom_screen/dashboard.dart';
import 'package:flutter/widgets.dart';

class HomeState {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({required this.selectedIndex, required this.views});

  // Initial state
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        DashboardScreen(),
       
      ],
    );
  }

  HomeState copyWith({int? selectedIndex, List<Widget>? views}) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }
}