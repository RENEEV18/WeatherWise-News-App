import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherwise_news_app/core/constants/images/images.dart';
import 'package:weatherwise_news_app/modules/splash/controllers/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeInOut,
                    padding: EdgeInsets.symmetric(
                      horizontal: controller.showText.value ? 10 : 0,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOut,
                          height: controller.showText.value ? 50 : 100,
                          width: controller.showText.value ? 50 : 100,
                          child: Image.asset(AppIcons.weatherLogo),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          width: controller.showText.value ? 12 : 0,
                        ),
                        controller.showText.value
                            ? FadeInRight(
                                duration: const Duration(milliseconds: 1000),
                                child: Text(
                                  "WeatherNews",
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  controller.showText.value
                      ? SizedBox(
                          height: 70,
                          child: LottieBuilder.asset(AppImageVectors.loadingSvg),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
