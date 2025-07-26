import 'package:get/get.dart';
import 'package:weatherwise_news_app/modules/splash/controllers/splash_controller.dart';

// This Class Represents All Splash Bindings DI.
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController(), permanent: false);
  }
}
