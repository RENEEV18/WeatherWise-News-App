import 'package:dio/dio.dart';
import 'package:weatherwise_news_app/core/config/api/api.dart';

// This Class Handles All Service Functions.
abstract class HomeService {
  final Dio dio = Dio();

  // Service function to get current weather data based on user location (City) & Forecast.
  Future<Response<dynamic>> getCurrentWeatherService(
      {required String city, required String units, required String type}) async {
    try {
      final weatherInfo = dio.get(
        "${AppApiUrl.weatherApiBaseUrl}/$type",
        queryParameters: {
          "q": city,
          "appid": AppApiUrl.weatherApiKey,
          "units": units,
        },
      );
      return weatherInfo;
    } catch (e) {
      rethrow;
    }
  }

  // Service function to get news headlines
  Future<Response<dynamic>> getNewsService({
    required String query,
    required int page,
    required int pageSize,
  }) async {
    try {
      final newsInfo = await dio.get(
        "${AppApiUrl.newsApiBaseUrl}/everything",
        queryParameters: {
          "q": query,
          "page": page,
          "pageSize": pageSize,
          "apiKey": AppApiUrl.newsApiKey,
        },
      );
      return newsInfo;
    } catch (e) {
      rethrow;
    }
  }
}
