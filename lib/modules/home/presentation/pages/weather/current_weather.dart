import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherwise_news_app/core/constants/colors/colors.dart';
import 'package:weatherwise_news_app/core/utils/extensions.dart';
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
          Text(
            "${weather.currentTemp.toStringAsFixed(0)} ${homeController.weatherState.value.selectedUnit == "metric" ? "°C" : "°F"}",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.primaryWhite,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            weather.weather,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.primaryWhite,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
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
        ],
      );
    });
  }
}
