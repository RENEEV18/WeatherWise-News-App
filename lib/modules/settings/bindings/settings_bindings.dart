// This Class Represents All Settings Bindings DI.
import 'package:get/get.dart';
import 'package:weatherwise_news_app/modules/settings/controllers/settings_controller.dart';

class SettingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}
