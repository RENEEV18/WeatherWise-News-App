import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherwise_news_app/core/utils/error_handlers.dart';
import 'package:weatherwise_news_app/core/utils/extensions.dart';
import 'package:weatherwise_news_app/modules/home/domain/entities/home_entity.dart';
import 'package:weatherwise_news_app/modules/home/domain/repositories/home_repo.dart';

// This Class Handles The Home Controller Functions
class HomeController extends GetxController {
  var weatherState = HomeEntity.initial().obs;
  final HomeRepo _homeRepo = Get.find<HomeRepo>();
  final SharedPreferences prefs = Get.find<SharedPreferences>();
  final HelperFormatFunctions formatter = Get.find<HelperFormatFunctions>();

  ////-------------WEATHER FUNCTIONS---------------------------------
  // OnInit function
  @override
  void onInit() {
    super.onInit();
    getCurrentCity();
  }

  // Controller function to get current weather data.
  getCurrentWeatherData({required String city, required String units}) async {
    weatherState.value = weatherState.value.copyWith(isWeatherDataLoading: true);
    try {
      await _homeRepo
          .getCurrentWeatherRepo(
        city: city,
        units: units,
      )
          .then(
        (value) {
          weatherState.value = weatherState.value.copyWith(
            isWeatherDataLoading: false,
            cityName: formatter.checkValue(value.name),
            currentTemp: value.main?.temp ?? 0.0,
            weather: value.weather == [] ? 'No data' : value.weather?.first.main,
            weatherDescription: value.weather == [] ? 'No description' : value.weather?.first.description ?? '',
            humidity: formatter.checkValue(value.main?.humidity.toString()),
            windSpeed: formatter.checkValue(value.wind?.speed.toString()),
            visibility: formatter.checkValue(value.visibility.toString()),
            pressure: formatter.checkValue(value.main?.pressure.toString()),
          );
          log("Sucess API Called : $value");
        },
      );
    } catch (e) {
      weatherState.value = weatherState.value.copyWith(
        isWeatherDataLoading: false,
        errorMessage: e.toString(),
      );
      AppErrorHandler.showError(e);
    }
  }

  // Controller function to get forecast data
  getForeCastData({required String city, required String units}) async {
    weatherState.value = weatherState.value.copyWith(isForecastLoading: true);
    try {
      await _homeRepo
          .getForecastRepo(
        city: city,
        units: units,
      )
          .then(
        (value) {
          final forecastList = value.list?.map((item) {
                return ForecastDayEntity(
                  day: formatter.formatDay(item.dtTxt),
                  temp: item.main?.temp ?? 0.0,
                  icon: item.weather?.first.icon ?? '',
                );
              }).toList() ??
              [];
          weatherState.value = weatherState.value.copyWith(
            isForecastLoading: false,
            forecast: forecastList,
          );
          log("Sucess API Called : $value");
        },
      );
    } catch (e) {
      weatherState.value = weatherState.value.copyWith(
        isForecastLoading: false,
        errorMessage: e.toString(),
      );
      AppErrorHandler.showError(e);
    }
  }

  ////-------------NEWS FUNCTIONS---------------------------------
  // Controller function to get news data
  getNewsData({required String country, required int page, required int pageSize}) async {
    weatherState.value = weatherState.value.copyWith(isNewsLoading: true);
    try {
      await _homeRepo
          .getNewsRepo(
        country: country,
        page: page,
        pageSize: pageSize,
      )
          .then(
        (value) {
          weatherState.value = weatherState.value.copyWith(
            isNewsLoading: false,
            getNewsModel: value,
          );
          log("Sucess API Called : $value");
        },
      );
    } catch (e) {
      weatherState.value = weatherState.value.copyWith(
        isNewsLoading: false,
        errorMessage: e.toString(),
      );
      AppErrorHandler.showError(e);
    }
  }

  ////-------------LOCATION FUNCTION---------------------------------
  // Location function to get the user current city
  Future<void> getCurrentCity() async {
    try {
      // Check location permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("Location services are disabled. Please enable them.");
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Location permissions are denied");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception("Location permissions are permanently denied. Please enable them in settings.");
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty || placemarks[0].locality == null) {
        throw Exception("Unable to fetch city from your location.");
      }

      String cityName = placemarks[0].locality ?? "Unknown City";
      String countryName = placemarks[0].country ?? "Unknown";
      log("Fecthed City : $cityName : $countryName");
      await prefs.setString("current_city", cityName);
      await prefs.setString("country_name", countryName);
      // Called the current weather data function
      await getCurrentWeatherData(
        city: prefs.getString("current_city") == null || prefs.getString("current_city").toString().isEmpty
            ? ""
            : prefs.getString("current_city").toString(),
        units: "metric",
      );
      // Called the current forecast data function
      await getForeCastData(
        city: prefs.getString("current_city") == null || prefs.getString("current_city").toString().isEmpty
            ? ""
            : prefs.getString("current_city").toString(),
        units: "metric",
      );
      // Called the current latest news data function
      await getNewsData(
        country: prefs.getString("country_name") == null || prefs.getString("country_name").toString().isEmpty
            ? ""
            : prefs.getString("country_name").toString(),
        page: 1,
        pageSize: 10,
      );
      weatherState.value = weatherState.value.copyWith(
        selectedUnit: "metric",
      );
    } catch (e) {
      AppErrorHandler.showError(e);
      rethrow;
    }
  }
}
