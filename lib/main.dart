import 'package:blue_sky/screens/home_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
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
