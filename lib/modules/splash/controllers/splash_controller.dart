import 'package:get/get.dart';
import 'package:weatherwise_news_app/routes/route_constants.dart';

//Splash Controller Class - Which Defines All Functions & Variables To Use In SplashScreen
class SplashController extends GetxController {
//Variable
  var showText = false.obs;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1), () {
      showText.value = true;
    });
    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(AppRouteConstants.homeRoute);
    });
  }
}
