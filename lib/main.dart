import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherwise_news_app/core/config/di/di.dart';
import 'package:weatherwise_news_app/core/constants/colors/app_themes.dart';
import 'package:weatherwise_news_app/modules/splash/controllers/theme_controller.dart';
import 'package:weatherwise_news_app/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Obx(
      () => GetMaterialApp(
        title: 'WeatherWise News App',
        initialBinding: AppBinding(),
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.theme,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
