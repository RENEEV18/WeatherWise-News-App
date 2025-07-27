import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherwise_news_app/core/constants/colors/colors.dart';
import 'package:weatherwise_news_app/core/constants/style/style.dart';
import 'package:weatherwise_news_app/core/utils/loader.dart';
import 'package:weatherwise_news_app/modules/home/presentation/controllers/home_controller.dart';
import 'package:weatherwise_news_app/modules/home/presentation/pages/news/news.dart';
import 'package:weatherwise_news_app/modules/home/presentation/pages/weather/current_weather.dart';
import 'package:weatherwise_news_app/modules/home/presentation/pages/weather/forecast.dart';
import 'package:weatherwise_news_app/modules/home/presentation/pages/weather/weather_details.dart';
import 'package:weatherwise_news_app/modules/home/presentation/widgets/no_internet.dart';
import 'package:weatherwise_news_app/modules/settings/controllers/settings_controller.dart';

import 'package:weatherwise_news_app/routes/route_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.find<HomeController>();
  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: double.infinity,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Obx(() {
            return Visibility(
              visible: !controller.weatherState.value.isWeatherDataLoading,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    spacing: 10,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: AppColors.primaryWhite,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.weatherState.value.cityName,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.primaryWhite,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            controller.prefs.getString("country_name") ?? 'Unknown',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: AppColors.primaryWhite.withValues(alpha: 0.7),
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
        actions: [
          Obx(() {
            return Visibility(
              visible: !controller.weatherState.value.isWeatherDataLoading,
              child: IconButton(
                onPressed: () {
                  Get.toNamed(AppRouteConstants.settingsRoute);
                },
                icon: const Icon(Icons.settings, color: AppColors.primaryWhite),
              ),
            );
          })
        ],
      ),
      body: Obx(() {
        return SafeArea(
          child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff1e2444),
                    Color(0xff2b2f5f),
                    Color(0xff373675),
                    Color(0xff51409b),
                    Color(0xff644aa4),
                    Color(0xff7654a6),
                  ],
                ),
              ),
              child: controller.weatherState.value.errorMessage.contains("PlatformException")
                  ? NoInternetScreen(
                      onPressed: () {
                        settingsController.resetSettings();
                        controller.getCurrentCity();
                      },
                    )
                  : NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowIndicator();
                        return true;
                      },
                      child: RefreshIndicator.adaptive(
                        onRefresh: () {
                          settingsController.resetSettings();
                          return controller.getCurrentCity();
                        },
                        child: SingleChildScrollView(
                          physics: controller.isExpanded.value
                              ? const NeverScrollableScrollPhysics()
                              : const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!controller.isExpanded.value)
                                controller.weatherState.value.isWeatherDataLoading
                                    ? SizedBox(
                                        height: 300,
                                        child: Column(
                                          spacing: 10,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            CommonLoadingWidget(),
                                            Text(
                                              "Loading Weather Data...",
                                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                    color: AppColors.primaryWhite,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Column(
                                        spacing: 10,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CurrentWeather(homeController: controller),
                                          WeatherDetails(homeController: controller),
                                          FiveDayForecast(homeController: controller),
                                        ],
                                      )
                              else
                                FadeOut(
                                  duration: const Duration(milliseconds: 800),
                                  child: SizedBox.shrink(),
                                ),
                              AppStyle.kHeight10,
                              FadeInUp(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.primaryWhite.withValues(alpha: 0.1),
                                  ),
                                  height: 600,
                                  child: NewsPage(controller: controller),
                                ),
                              ),
                              AppStyle.kHeight20,
                            ],
                          ),
                        ),
                      ),
                    )),
        );
      }),
      bottomNavigationBar: Container(
        height: 10,
        color: const Color(0xff7654a6),
      ),
    );
  }
}
