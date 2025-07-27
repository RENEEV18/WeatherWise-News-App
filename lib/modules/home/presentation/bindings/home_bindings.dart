import 'package:get/get.dart';
import 'package:weatherwise_news_app/modules/home/data/repositories/home_repo_iml.dart';
import 'package:weatherwise_news_app/modules/home/domain/repositories/home_repo.dart';
import 'package:weatherwise_news_app/modules/home/presentation/controllers/home_controller.dart';
import 'package:weatherwise_news_app/modules/settings/controllers/settings_controller.dart';

// This Class Represents All Home Bindings DI.
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeRepo>(() => HomeRepoIml());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SettingsController());
  }
}
