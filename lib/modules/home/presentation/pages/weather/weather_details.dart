import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherwise_news_app/core/constants/colors/colors.dart';
import 'package:weatherwise_news_app/modules/home/presentation/controllers/home_controller.dart';
import 'package:weatherwise_news_app/modules/home/presentation/widgets/weather_details_item_widget.dart';

class WeatherDetails extends StatefulWidget {
  const WeatherDetails({super.key, required this.homeController});
  final HomeController homeController;

  @override
  State<WeatherDetails> createState() => WeatherDetailsState();
}

class WeatherDetailsState extends State<WeatherDetails> {
  final List<String> weatherDataItems = [
    "Pressure",
    "Humidity",
    "Wind Speed",
    "Visibility",
  ];
  final List<IconData> weatherDataIcons = [
    Icons.waves,
    Icons.water_drop_outlined,
    Icons.air_outlined,
    Icons.wb_sunny_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final weather = widget.homeController.weatherState.value;

        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2,
          ),
          itemBuilder: (context, index) {
            var valueItems = [
              weather.pressure,
              weather.humidity.toString(),
              weather.windSpeed.toString(),
              weather.visibility.toString(),
            ];
            return FadeInUp(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: WeatherDetailItem(
                  title: weatherDataItems[index],
                  value: valueItems[index],
                  iconData: weatherDataIcons[index],
                ),
              ),
            );
          },
          itemCount: 4,
        );
      },
    );
  }
}
