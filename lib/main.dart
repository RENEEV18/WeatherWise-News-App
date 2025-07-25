import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherwise_news_app/core/config/di/di.dart';
import 'package:weatherwise_news_app/routes/routes.dart';

void main() {
  AppBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'WeatherWise News App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
