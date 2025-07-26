import 'package:dio/dio.dart';
import 'package:weatherwise_news_app/core/config/api/api.dart';

// This Class Handles All Service Functions.
abstract class HomeService {
  final Dio dio = Dio();

  // Service function to get current weather data based on user location (City) & Forecast.
  Future<Response<dynamic>> getCurrentWeatherService(
      {required String city, required String units, required String type}) async {
    try {
      final userInfo = dio.get(
        "${AppApiUrl.apiBaseUrl}/$type",
        queryParameters: {
          "q": city,
          "appid": AppApiUrl.apiKey,
          "units": units,
        },
      );
      return userInfo;
    } catch (e) {
      rethrow;
    }
  }
}
