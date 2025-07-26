// This Class Handles All Entity Variables.
import 'package:weatherwise_news_app/modules/home/data/models/news_model/get_news_model.dart';

class HomeEntity {
  final bool isWeatherDataLoading;
  final bool isForecastLoading;
  final bool isNewsLoading;

  // Current Weather Info
  final String cityName;
  final double currentTemp;
  final String weather;
  final String weatherDescription;
  final String humidity;
  final String pressure;
  final String windSpeed;
  final String visibility;
  final String selectedUnit;

  // Forecast
  final List<ForecastDayEntity> forecast;
  // News
  final GetNewsModel getNewsModel;
  final String errorMessage;

  const HomeEntity({
    required this.isWeatherDataLoading,
    required this.isForecastLoading,
    required this.isNewsLoading,
    required this.cityName,
    required this.currentTemp,
    required this.weatherDescription,
    required this.humidity,
    required this.windSpeed,
    required this.visibility,
    required this.selectedUnit,
    required this.weather,
    required this.pressure,
    required this.forecast,
    required this.getNewsModel,
    required this.errorMessage,
  });

  /// Initial/default state
  factory HomeEntity.initial() {
    return HomeEntity(
      isWeatherDataLoading: true,
      isForecastLoading: true,
      isNewsLoading: true,
      cityName: '',
      currentTemp: 0.0,
      weatherDescription: '',
      humidity: '',
      windSpeed: '',
      visibility: '',
      selectedUnit: '',
      weather: '',
      pressure: '',
      forecast: [],
      getNewsModel: GetNewsModel(),
      errorMessage: '',
    );
  }

  /// CopyWith method for immutability
  HomeEntity copyWith({
    bool? isWeatherDataLoading,
    bool? isForecastLoading,
    bool? isNewsLoading,
    String? cityName,
    double? currentTemp,
    String? weatherDescription,
    String? humidity,
    String? windSpeed,
    String? visibility,
    String? selectedUnit,
    String? weather,
    String? pressure,
    List<ForecastDayEntity>? forecast,
    GetNewsModel? getNewsModel,
    String? errorMessage,
  }) {
    return HomeEntity(
      isWeatherDataLoading: isWeatherDataLoading ?? this.isWeatherDataLoading,
      isForecastLoading: isForecastLoading ?? this.isForecastLoading,
      isNewsLoading: isNewsLoading ?? this.isNewsLoading,
      cityName: cityName ?? this.cityName,
      currentTemp: currentTemp ?? this.currentTemp,
      weatherDescription: weatherDescription ?? this.weatherDescription,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      visibility: visibility ?? this.visibility,
      selectedUnit: selectedUnit ?? this.selectedUnit,
      weather: weather ?? this.weather,
      pressure: pressure ?? this.pressure,
      forecast: forecast ?? this.forecast,
      getNewsModel: getNewsModel ?? this.getNewsModel,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class ForecastDayEntity {
  final String day;
  final double temp;
  final String icon;

  ForecastDayEntity({
    required this.day,
    required this.temp,
    required this.icon,
  });
}
