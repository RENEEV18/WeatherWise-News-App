import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:weatherwise_news_app/core/constants/colors/colors.dart';

// This Class Represents All The Error Handling Conditions.
class AppErrorHandler {
  /// User centric snackbar

  static void showError(dynamic error) {
    final message = _mapErrorToMessage(error);
    Get.snackbar(
      "Oops!",
      backgroundColor: AppColors.primaryWhite,
      colorText: AppColors.primaryColor,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }

  // Other error conditions
  static String _mapErrorToMessage(dynamic error) {
    log("error message : $error");
    if (error is SocketException || error is PlatformException) {
      return "No internet connection. Please check your network.";
    } else if (error is TimeoutException) {
      return "The request timed out. Try again later.";
    } else if (error.toString().contains('Location services are disabled')) {
      return "Please enable location services.";
    } else if (error.toString().contains('permissions are denied')) {
      return "Location permission is required to fetch weather.";
    } else if (error.toString().contains('Unable to fetch city')) {
      return "We couldn't fetch your location. Try again.";
    } else if (error.toString().toLowerCase().contains("401")) {
      return "Unauthorized request. Please try again.";
    } else if (error.toString().toLowerCase().contains("500")) {
      return "Server error. Please try again later.";
    }
    return "Something went wrong. Please try again.";
  }
}
