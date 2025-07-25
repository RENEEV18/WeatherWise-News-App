import 'package:get/get.dart';
import 'package:weatherwise_news_app/modules/splash/controllers/splash_controller.dart';
import 'package:weatherwise_news_app/modules/splash/controllers/theme_controller.dart';

// The Class Handles All Dependency-Injections
class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Registering all controllers
    Get.put(SplashController(), permanent: true);
    Get.put(ThemeController(), permanent: true);
    // Get.lazyPut(() => HomeController());
  }
}
