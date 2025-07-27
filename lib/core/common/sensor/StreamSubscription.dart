import 'dart:async';
import 'dart:math';

import 'package:batch34_b/features/auth/presentation/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccelerometerView extends StatefulWidget {
  const AccelerometerView({super.key});

  @override
  State<AccelerometerView> createState() => _AccelerometerViewState();
}

class _AccelerometerViewState extends State<AccelerometerView> {
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription;
  AccelerometerEvent? _lastEvent;
  final double shakeThreshold = 15.0;
  DateTime? _lastShakeTime;

  @override
  void initState() {
    super.initState();
    _startAccelerometer();
  }

  void _startAccelerometer() {
    _accelerometerSubscription = accelerometerEvents.listen((
      AccelerometerEvent event,
    ) {
      if (_lastEvent != null) {
        double deltaX = (event.x - _lastEvent!.x).abs();
        double deltaY = (event.y - _lastEvent!.y).abs();
        double deltaZ = (event.z - _lastEvent!.z).abs();

        double delta = sqrt(
          deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ,
        );

        if (delta > shakeThreshold) {
          final now = DateTime.now();
          if (_lastShakeTime == null ||
              now.difference(_lastShakeTime!) > Duration(seconds: 2)) {
            _lastShakeTime = now;
            _logout();
          }
        }
      }
      _lastEvent = event;
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }

  @override
  void dispose() {
    _accelerometerSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Accelerometer Logout')),
      body: const Center(child: Text('Shake the device to logout')),
    );
  }
}
