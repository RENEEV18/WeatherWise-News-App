import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherwise_news_app/core/utils/extensions.dart';

// The Class Handles All Global Dependency-Injections
class AppBinding extends Bindings {
  @override
  void dependencies() async {
    final prefs = await SharedPreferences.getInstance();
    final helperFormatter = HelperFormatFunctions();
    Get.put<SharedPreferences>(prefs, permanent: true);
    Get.put<HelperFormatFunctions>(helperFormatter, permanent: true);
  }
}
