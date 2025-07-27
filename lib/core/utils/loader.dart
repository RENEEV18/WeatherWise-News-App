import 'package:flutter/material.dart';
import 'package:weatherwise_news_app/core/constants/colors/colors.dart';

class CommonLoadingWidget extends StatelessWidget {
  const CommonLoadingWidget({super.key, this.circleColor, this.circleValue});
  final Color? circleColor;
  final double? circleValue;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: circleColor ?? AppColors.primaryWhite,
        strokeWidth: 2.5,
        value: circleValue,
      ),
    );
  }
}
