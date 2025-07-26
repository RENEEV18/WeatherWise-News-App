import 'dart:developer';

import 'package:weatherwise_news_app/modules/home/data/datasources/home_service.dart';
import 'package:weatherwise_news_app/modules/home/data/models/get_current_weather_model.dart';
import 'package:weatherwise_news_app/modules/home/data/models/get_forecast_model.dart';
import 'package:weatherwise_news_app/modules/home/domain/repositories/home_repo.dart';

// This Class Handles All The Repo Implementations.
class HomeRepoIml extends HomeService implements HomeRepo {
// Repo function to get current weather data.
  @override
  Future<GetCurrentWeatherModel> getCurrentWeatherRepo({
    required String city,
    required String units,
    required String type,
  }) async {
    try {
      final response = await getCurrentWeatherService(
        city: city,
        units: units,
        type: type,
      );
      return GetCurrentWeatherModel.fromJson(response.data);
    } catch (e) {
      log("Repository error for weather: $e");
      throw Exception("Failed to fetch weather data");
    }
  }

// Repo function to get forecast data.
  @override
  Future<GetForecastModel> getForecastRepo({
    required String city,
    required String units,
    required String type,
  }) async {
    try {
      final response = await getCurrentWeatherService(
        city: city,
        units: units,
        type: type,
      );
      return GetForecastModel.fromJson(response.data);
    } catch (e) {
      log("Repository error for forecast: $e");
      throw Exception("Failed to fetch forecast data");
    }
  }
}
