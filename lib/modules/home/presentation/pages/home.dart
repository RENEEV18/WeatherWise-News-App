import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherwise_news_app/core/constants/colors/colors.dart';
import 'package:weatherwise_news_app/core/constants/style/style.dart';
import 'package:weatherwise_news_app/core/utils/shimmer.dart';
import 'package:weatherwise_news_app/modules/home/presentation/controllers/home_controller.dart';
import 'package:weatherwise_news_app/modules/home/presentation/pages/news/news.dart';
import 'package:weatherwise_news_app/modules/home/presentation/pages/weather/current_weather.dart';
import 'package:weatherwise_news_app/modules/home/presentation/pages/weather/forecast.dart';
import 'package:weatherwise_news_app/modules/home/presentation/pages/weather/weather_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.find<HomeController>();

  double newsContainerHeight = 400;
  double weatherOpacity = 1.0;
  bool isExpanded = false;

  void _onScroll(double offset, BuildContext context) {
    double expandTrigger = 100; // scroll threshold to trigger expand/collapse
    double fadeStart = 50;
    double fadeEnd = 200;

    // If scrolled down beyond threshold -> Expand
    if (offset > expandTrigger && !isExpanded) {
      setState(() {
        newsContainerHeight = MediaQuery.of(context).size.height - 100;
        weatherOpacity = 0.0;
        isExpanded = true;
      });
    }

    // If scrolled back up close to the top -> Collapse
    if (offset <= 20 && isExpanded) {
      setState(() {
        newsContainerHeight = 400;
        weatherOpacity = 1.0;
        isExpanded = false;
      });
    }

    // Smooth weather fading while scrolling
    double fadeOpacity = 1 - (offset - fadeStart) / (fadeEnd - fadeStart);
    weatherOpacity = fadeOpacity.clamp(0.0, 1.0);
  }

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
            return Row(
              children: [
                const Icon(Icons.location_on_outlined, color: AppColors.primaryWhite),
                Text(
                  controller.weatherState.value.cityName,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.primaryWhite,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            );
          }),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: AppColors.primaryWhite),
          )
        ],
      ),
      body: Obx(() {
        return SafeArea(
          child: Container(
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
            child: controller.weatherState.value.isWeatherDataLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CommonLoadingWidget(),
                      Text(
                        "Loading Weather Data...",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: AppColors.primaryWhite,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  )
                : NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification.metrics.axis == Axis.vertical) {
                        _onScroll(notification.metrics.pixels, context);
                      }
                      return false;
                    },
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        AnimatedOpacity(
                          opacity: weatherOpacity,
                          duration: const Duration(milliseconds: 400),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 20,
                            children: [
                              CurrentWeather(homeController: controller),
                              WeatherDetails(homeController: controller),
                              FiveDayForecast(homeController: controller),
                            ],
                          ),
                        ),
                        AppStyle.kHeight10,
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          height: newsContainerHeight,
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: NewsPage(
                            controller: controller,
                          ),
                        ),
                        AppStyle.kHeight20,
                      ],
                    ),
                  ),
          ),
        );
      }),
      bottomNavigationBar: Container(
        height: 10,
        color: const Color(0xff7654a6),
      ),
    );
  }
}
