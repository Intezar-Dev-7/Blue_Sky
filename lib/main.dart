import 'package:blue_sky/screens/home_screen.dart';
import 'package:blue_sky/services/background_notification.dart';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:workmanager/workmanager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize workmanager for background tasks

  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  // Register a  periodic background task  to fetch weather updates evry 8 hours
  await Workmanager().registerPeriodicTask(
    "weatherTask",
    "fetchWeather",
    frequency: const Duration(minutes: 15),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: HomeScreen(),
      title: "Blue Sky",
      debugShowCheckedModeBanner: false,
    );
  }
}
