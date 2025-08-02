import 'dart:async';
import 'dart:io' show Platform;

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:proximity_sensor/proximity_sensor.dart';

import 'themeviewmodel/theme_bloc.dart';
import 'themeviewmodel/theme_event.dart';

class ProximityThemeManager extends ChangeNotifier {
  StreamSubscription<dynamic>? _proximitySubscription;
  bool _isNear = false;

  ProximityThemeManager({required ThemeBloc themeBloc}) {
    _checkAndStart(themeBloc);
  }

  Future<void> _checkAndStart(ThemeBloc themeBloc) async {
    if (kIsWeb) return; // Proximity not supported on web

    try {
      if (Platform.isAndroid) {
        _startListening(themeBloc);
      } else if (Platform.isIOS) {
        final iosInfo = await DeviceInfoPlugin().iosInfo;
        if (!iosInfo.isPhysicalDevice) {
          debugPrint("Proximity sensor skipped: running on iOS simulator.");
          return;
        }
        _startListening(themeBloc);
      }
    } catch (e) {
      debugPrint("Error initializing proximity sensor: $e");
    }
  }

  void _startListening(ThemeBloc themeBloc) {
    _proximitySubscription = ProximitySensor.events.listen((int event) {
      bool isNearNow = event == 1;

      if (isNearNow && !_isNear) {
        themeBloc.add(ToggleThemeEvent());
      }

      _isNear = isNearNow;
    });
  }

  @override
  void dispose() {
    _proximitySubscription?.cancel();
    super.dispose();
  }
}
