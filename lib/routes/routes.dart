import 'package:get/get.dart';
import 'package:weatherwise_news_app/modules/home/presentation/bindings/home_bindings.dart';
import 'package:weatherwise_news_app/modules/home/presentation/pages/home.dart';
import 'package:weatherwise_news_app/modules/splash/bindings/splash_bindings.dart';
import 'package:weatherwise_news_app/modules/splash/pages/splash.dart';
import 'package:weatherwise_news_app/routes/route_constants.dart';

class AppRoutes {
  static final routes = [
    GetPage(
      name: AppRouteConstants.splashRoute,
      page: () => SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRouteConstants.homeRoute,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
