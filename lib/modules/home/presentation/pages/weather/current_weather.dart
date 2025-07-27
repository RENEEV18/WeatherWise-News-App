import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherwise_news_app/core/constants/colors/colors.dart';
import 'package:weatherwise_news_app/core/utils/extensions.dart';
import 'package:weatherwise_news_app/core/utils/loader.dart';
import 'package:weatherwise_news_app/modules/home/presentation/controllers/home_controller.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key, required this.homeController});
  final HomeController homeController;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final weather = homeController.weatherState.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: FadeInLeft(
                  child: Text(
                    "${weather.currentTemp.toStringAsFixed(0)} ${homeController.weatherState.value.selectedUnit == "metric" ? "°C" : "°F"}",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.primaryWhite,
                          fontSize: 80,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              Expanded(
                child: Image.network(
                  getWeatherIconUrl(homeController.weatherState.value.icon),
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                  loadingBuilder: (
                    context,
                    child,
                    loadingProgress,
                  ) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return SizedBox(
                      width: 40,
                      height: 40,
                      child: Center(
                          child: CommonLoadingWidget(
                        circleValue: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      )),
                    );
                  },
                  errorBuilder: (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return Icon(
                      Icons.cloud_off_sharp,
                      size: 32,
                    );
                  },
                ),
              ),
            ],
          ),
          FadeInLeft(
            delay: Duration(milliseconds: 200),
            child: Text(
              weather.weather,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primaryWhite,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          FadeInLeft(
            delay: Duration(milliseconds: 200),
            child: Text(
              weather.weatherDescription.toTitleCase(),
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.primaryWhite.withValues(
                      alpha: 0.5,
                    ),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      );
    });
  }

  String getWeatherIconUrl(String iconCode) {
    return "https://openweathermap.org/img/wn/$iconCode@2x.png";
  }
}
