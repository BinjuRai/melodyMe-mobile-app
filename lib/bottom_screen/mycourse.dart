import 'package:flutter/material.dart';

class Mycourse extends StatefulWidget {
  const Mycourse({super.key});

  @override
  State<Mycourse> createState() => _MycourseState();
}

class _MycourseState extends State<Mycourse> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('My course'));
  }
}
