import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This Class Handles The Settings Controller Functions
class SettingsController extends GetxController {
  final SharedPreferences prefs = Get.find<SharedPreferences>();

  // Initialising RX variables.
  RxString selectedUnit = 'Celsius'.obs;
  RxBool isLoading = false.obs;

  final List<String> categories = [
    'business',
    'crime',
    'domestic',
    'education',
    'entertainment',
    'environment',
    'food',
    'health',
    'lifestyle',
    'other',
    'politics',
    'science',
    'sports',
    'technology',
    'top',
    'tourism',
    'world'
  ];
  RxList<String> selectedCategories = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadPreferences();
  }

  /// Load saved preferences
  void _loadPreferences() {
    selectedUnit.value = prefs.getString('selectedUnit') ?? 'Celsius';
    selectedCategories.value = prefs.getStringList('selectedCategories') ?? [];
  }

  /// Update the temperature unit
  void setUnit(String unit) {
    selectedUnit.value = unit;
    prefs.setString('selectedUnit', unit);
  }

  /// Toggle category selection (max 5)
  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      if (selectedCategories.length < 5) {
        selectedCategories.add(category);
      }
    }
    prefs.setStringList('selectedCategories', selectedCategories);
  }

  // Reset all settings to default
  void resetSettings() {
    selectedUnit.value = 'Celsius';
    selectedCategories.clear();
    prefs.remove('selectedUnit');
    prefs.remove('selectedCategories');
  }

  // Return categories in `OR` format for API call
  String get formattedCategories => selectedCategories.isEmpty ? '' : selectedCategories.join(' OR ');
}
