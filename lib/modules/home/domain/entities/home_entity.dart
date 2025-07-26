import 'package:flutter/material.dart';
import 'package:weatherwise_news_app/modules/home/data/models/get_current_weather_model.dart';
import 'package:weatherwise_news_app/modules/home/data/models/get_forecast_model.dart';

// This Class Handles All Entity Variables.
@immutable
class WeatherEntity {
  final bool isWeatherDataLoading;
  final bool isForecastLoading;
  final GetCurrentWeatherModel weatherModel;
  final GetForecastModel forecastModel;
  final String errorMessage;

  const WeatherEntity({
    required this.isWeatherDataLoading,
    required this.isForecastLoading,
    required this.weatherModel,
    required this.forecastModel,
    required this.errorMessage,
  });

  /// Initial/default state
  factory WeatherEntity.initial() {
    return WeatherEntity(
      isWeatherDataLoading: false,
      isForecastLoading: false,
      weatherModel: GetCurrentWeatherModel(),
      forecastModel: GetForecastModel(),
      errorMessage: '',
    );
  }

  /// CopyWith method for immutability
  WeatherEntity copyWith({
    bool? isWeatherDataLoading,
    bool? isForecastLoading,
    GetCurrentWeatherModel? weatherModel,
    GetForecastModel? forecastModel,
    String? errorMessage,
  }) {
    return WeatherEntity(
      isWeatherDataLoading: isWeatherDataLoading ?? this.isWeatherDataLoading,
      isForecastLoading: isForecastLoading ?? this.isForecastLoading,
      weatherModel: weatherModel ?? this.weatherModel,
      forecastModel: forecastModel ?? this.forecastModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
