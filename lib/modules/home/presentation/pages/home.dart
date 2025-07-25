import 'package:flutter/material.dart';
import 'package:weatherwise_news_app/core/constants/colors/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: double.infinity,
        leading: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: AppColors.primaryWhite,
                  ),
                  Text(
                    "Nairobi, Kenya",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.primaryWhite,
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: AppColors.primaryWhite),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
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
        )),
        child: const SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CurrentWeather(),
                WeatherDetails(),
                FiveDayForecast(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          "36°C",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.primaryWhite,
                fontSize: 80,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          "Clear and Cloudy",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primaryWhite,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          "Cloudy. No precipitation expected over the next 24 hours",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.primaryWhite.withValues(
                  alpha: 0.5,
                ),
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }
}

class WeatherDetails extends StatefulWidget {
  const WeatherDetails({super.key});

  @override
  State<WeatherDetails> createState() => WeatherDetailsState();
}

class WeatherDetailsState extends State<WeatherDetails> {
  final List<String> weatherData = [
    "Temperature",
    "Humidity",
    "Wind Speed",
    "Visibility",
  ];

  @override
  Widget build(BuildContext context) {
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
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primaryWhite.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: WeatherDetailItem(
            title: weatherData[index],
            value: "16°",
          ),
        );
      },
      itemCount: 4,
    );
  }
}

class WeatherDetailItem extends StatelessWidget {
  final String title;
  final String value;

  const WeatherDetailItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primaryWhite,
                fontWeight: FontWeight.w500,
              ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.primaryWhite.withValues(
                  alpha: 0.5,
                ),
                fontWeight: FontWeight.w500,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class FiveDayForecast extends StatelessWidget {
  const FiveDayForecast({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> forecast = [
      {"day": "Mon", "temp": "16°", "icon": Icons.wb_cloudy},
      {"day": "Tue", "temp": "12°", "icon": Icons.cloud_queue},
      {"day": "Wed", "temp": "6°", "icon": Icons.umbrella},
      {"day": "Thu", "temp": "4°", "icon": Icons.thunderstorm},
    ];

    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "5-Days Forecast",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.primaryWhite,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: forecast.length,
            itemBuilder: (context, index) {
              final item = forecast[index];
              return Container(
                margin: EdgeInsets.only(right: 12),
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item["icon"], color: AppColors.primaryWhite, size: 32),
                    SizedBox(height: 8),
                    Text(
                      item["temp"],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryWhite,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      item["day"],
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
      ],
    );
  }
}
