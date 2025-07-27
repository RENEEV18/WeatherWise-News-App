import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:weatherwise_news_app/core/constants/colors/colors.dart';
import 'package:weatherwise_news_app/core/utils/loader.dart';
import 'package:weatherwise_news_app/modules/home/presentation/controllers/home_controller.dart';

class FiveDayForecast extends StatefulWidget {
  const FiveDayForecast({super.key, required this.homeController});
  final HomeController homeController;

  @override
  State<FiveDayForecast> createState() => _FiveDayForecastState();
}

class _FiveDayForecastState extends State<FiveDayForecast> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final weather = widget.homeController.weatherState.value;
      return FadeInRight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Text(
              "5-Days Forecast",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.primaryWhite,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 160,
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: controller,
                    child: ListView.builder(
                      controller: controller,
                      scrollDirection: Axis.horizontal,
                      itemCount: weather.forecast.length,
                      itemBuilder: (context, index) {
                        final item = weather.forecast[index];
                        return Container(
                          margin: const EdgeInsets.only(right: 12, bottom: 20),
                          width: MediaQuery.of(context).size.width * 0.28,
                          height: 120,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.primaryWhite.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                getWeatherIconUrl(item.icon),
                                width: 50,
                                height: 50,
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
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              (loadingProgress.expectedTotalBytes ?? 1)
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
                              const SizedBox(height: 8),
                              Text(
                                "${item.temp.toStringAsFixed(0)}°",
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: AppColors.primaryWhite,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              Text(
                                item.day,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: AppColors.primaryWhite.withValues(alpha: 0.7),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  String getWeatherIconUrl(String iconCode) {
    return "https://openweathermap.org/img/wn/$iconCode@2x.png";
  }
}
