import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weatherwise_news_app/core/constants/colors/colors.dart';

class ShimmerBox extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;

  const ShimmerBox({
    super.key,
    required this.height,
    required this.width,
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade200,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

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
