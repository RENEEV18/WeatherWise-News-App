import 'dart:developer';

import 'package:weatherwise_news_app/modules/home/data/datasources/home_service.dart';
import 'package:weatherwise_news_app/modules/home/data/models/news_model/get_news_model.dart';
import 'package:weatherwise_news_app/modules/home/data/models/weather_models/get_current_weather_model.dart';
import 'package:weatherwise_news_app/modules/home/data/models/weather_models/get_forecast_model.dart';
import 'package:weatherwise_news_app/modules/home/domain/repositories/home_repo.dart';

// This Class Handles All The Repo Implementations.
class HomeRepoIml extends HomeService implements HomeRepo {
// Repo function to get current weather data.
  @override
  Future<GetCurrentWeatherModel> getCurrentWeatherRepo({
    required String city,
    required String units,
  }) async {
    try {
      final response = await getCurrentWeatherService(
        city: city,
        units: units,
        type: "weather",
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
  }) async {
    try {
      final response = await getCurrentWeatherService(
        city: city,
        units: units,
        type: "forecast",
      );
      return GetForecastModel.fromJson(response.data);
    } catch (e) {
      log("Repository error for forecast: $e");
      throw Exception("Failed to fetch forecast data");
    }
  }

  // Repo function to get news data.
  @override
  Future<GetNewsModel> getNewsRepo({
    required String country,
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await getNewsService(
        query: country,
        page: page,
        pageSize: pageSize,
      );
      return GetNewsModel.fromJson(response.data);
    } catch (e) {
      log("Repository error for news: $e");
      throw Exception("Failed to fetch news data");
    }
  }
}
