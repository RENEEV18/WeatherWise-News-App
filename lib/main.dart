import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherwise_news_app/core/config/bindings/bindings.dart';
import 'package:weatherwise_news_app/core/utils/shared_pref.dart';
import 'package:weatherwise_news_app/routes/route_constants.dart';
import 'package:weatherwise_news_app/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetItService().setupLocator();
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
      initialRoute: AppRouteConstants.splashRoute,
      getPages: AppRoutes.routes,
      initialBinding: AppBinding(),
    );
  }
}
