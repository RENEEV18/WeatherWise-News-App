import 'package:flutter/material.dart';
import 'package:weatherwise_news_app/core/constants/colors/colors.dart';
import 'package:weatherwise_news_app/core/constants/style/style.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.wifi_off, size: 80, color: AppColors.primaryWhite),
        Text(
          "Something went wrong!",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primaryWhite),
        ),
        Text(
          "Please check your internet connection or try again later",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.primaryWhite.withValues(alpha: 0.8),
                fontSize: 13,
              ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryWhite,
            foregroundColor: AppColors.blackText,
          ),
          onPressed: onPressed,
          child: Text("Retry"),
        ),
        AppStyle.kHeight30
      ],
    );
  }
}
