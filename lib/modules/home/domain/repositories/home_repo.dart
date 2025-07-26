import 'package:weatherwise_news_app/modules/home/data/models/news_model/get_news_model.dart';
import 'package:weatherwise_news_app/modules/home/data/models/weather_models/get_current_weather_model.dart';
import 'package:weatherwise_news_app/modules/home/data/models/weather_models/get_forecast_model.dart';

// This Class Hanldes All Repo Functions
abstract class HomeRepo {
  // Function to get weather
  Future<GetCurrentWeatherModel> getCurrentWeatherRepo({
    required String city,
    required String units,
  });
  // Function to get forecast
  Future<GetForecastModel> getForecastRepo({
    required String city,
    required String units,
  });
  // Function to get news
  Future<GetNewsModel> getNewsRepo({
    required String country,
    required int page,
    required int pageSize,
  });
}
