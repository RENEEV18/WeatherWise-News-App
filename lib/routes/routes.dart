import 'package:flutter/material.dart';
import 'package:weatherwise_news_app/modules/home/presentation/pages/home.dart';
import 'package:weatherwise_news_app/modules/splash/pages/splash.dart';
import 'package:weatherwise_news_app/routes/route_constants.dart';

// The Class Represents All Route Initialisation Used.
class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // App Route for splash
      case AppRouteConstants.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      // App Route for home
      case AppRouteConstants.homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      // App Route for default
      default:
        return MaterialPageRoute(builder: (_) => SplashScreen());
    }
  }
}
