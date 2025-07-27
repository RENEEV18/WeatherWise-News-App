import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherwise_news_app/core/constants/colors/colors.dart';
import 'package:weatherwise_news_app/core/constants/style/style.dart';
import 'package:weatherwise_news_app/core/utils/loader.dart';
import 'package:weatherwise_news_app/modules/home/presentation/controllers/home_controller.dart';
import 'package:weatherwise_news_app/modules/settings/controllers/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final SettingsController controller = Get.find<SettingsController>();
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.primaryWhite,
        elevation: 0,
        title: Text(
          "Settings",
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: AppColors.primaryWhite, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: AppPadding.scaffoldPadding,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
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
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    // Temperature Unit Selection
                    Text(
                      "Preferred Temperature Unit",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.primaryWhite,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Obx(() => Row(
                          children: ['Celsius', 'Fahrenheit'].map((unit) {
                            return Expanded(
                              child: RadioListTile<String>(
                                value: unit,
                                groupValue: controller.selectedUnit.value,
                                onChanged: (value) => controller.setUnit(value!),
                                activeColor: AppColors.primaryWhite,
                                title: Text(
                                  unit,
                                  style:
                                      Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryWhite),
                                ),
                              ),
                            );
                          }).toList(),
                        )),

                    // Categories Selection
                    Text(
                      "Select News Categories (Max 5)",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppColors.primaryWhite,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Obx(() => Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.primaryWhite.withValues(alpha: 0.1),
                          ),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: controller.categories.map((category) {
                              final isSelected = controller.selectedCategories.contains(category);
                              return ChoiceChip(
                                label: Text(
                                  category,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: isSelected ? AppColors.blackText : AppColors.primaryWhite,
                                      ),
                                ),
                                selected: isSelected,
                                checkmarkColor: isSelected ? AppColors.blackText : AppColors.primaryWhite,
                                onSelected: (_) => controller.toggleCategory(category),
                                color: WidgetStatePropertyAll(isSelected ? AppColors.whiteText : Color(0xff373675)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: const BorderSide(
                                    color: AppColors.primaryWhite,
                                    width: 1.2,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            // Apply Changes Button
            Padding(
              padding: AppPadding.bottomButtonP,
              child: Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryWhite,
                      foregroundColor: AppColors.blackText,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            controller.isLoading.value = true;
                            await homeController.getCurrentWeatherData(
                              city: homeController.prefs.getString("current_city") ?? "",
                              units: controller.selectedUnit.value == "Celsius" ? "metric" : "imperial",
                            );
                            await homeController.getForeCastData(
                              city: homeController.prefs.getString("current_city") ?? "",
                              units: controller.selectedUnit.value == "Celsius" ? "metric" : "imperial",
                            );
                            await homeController.getNewsData(
                              country: controller.formattedCategories.isEmpty
                                  ? homeController.prefs.getString("country_name") ?? ""
                                  : controller.formattedCategories,
                              page: 1,
                              pageSize: 10,
                            );
                            homeController.changeUnit(
                                value: controller.selectedUnit.value == "Celsius" ? "metric" : "imperial");

                            controller.isLoading.value = false;
                            Get.back();
                          },
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CommonLoadingWidget(
                              circleColor: AppColors.blackText,
                            ))
                        : Text(
                            "Apply Changes",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.blackText,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
