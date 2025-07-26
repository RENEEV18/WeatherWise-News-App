import 'package:flutter/material.dart';
import 'package:weatherwise_news_app/core/constants/colors/colors.dart';

class WeatherDetailItem extends StatelessWidget {
  final String title;
  final String value;
  final IconData iconData;

  const WeatherDetailItem({super.key, required this.title, required this.value, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: Icon(
            iconData,
            color: AppColors.primaryWhite.withValues(alpha: 0.8),
            size: 30,
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primaryWhite, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
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
          ),
        ),
      ],
    );
  }
}
