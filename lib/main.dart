

import 'package:batch34_b/app.dart';
import 'package:batch34_b/app/service_locator/service_locator.dart';
import 'package:batch34_b/core/network/hive_service.dart';
import 'package:flutter/widgets.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  // init Hive service
  await HiveService().init();
  // Delete database
  await HiveService().clearAll();
  runApp(App());
}

