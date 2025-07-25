import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controller Class For Handling Theme Section
class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  // Function for changing the theme.
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(theme);
  }
}
