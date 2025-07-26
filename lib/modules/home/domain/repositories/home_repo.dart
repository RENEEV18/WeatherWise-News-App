import 'package:weatherwise_news_app/modules/home/data/models/get_current_weather_model.dart';
import 'package:weatherwise_news_app/modules/home/data/models/get_forecast_model.dart';

// This Class Hanldes All Repo Functions
abstract class HomeRepo {
  Future<GetCurrentWeatherModel> getCurrentWeatherRepo({
    required String city,
    required String units,
    required String type,
  });
  Future<GetForecastModel> getForecastRepo({
    required String city,
    required String units,
    required String type,
  });
}
