import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/erros/exceptions.dart';
import 'package:weather_app/core/utils/constants.dart';
import 'package:weather_app/features/weather_forcast/data/models/weather_forecast_model.dart';

abstract class ForecastLocalDatasource {
  ///sets weather forecast data to local storage
  Future<void> setForecastDataLocally(WeatherForecastModel forecastData);

  /// fetches weather forecast data from local storage
  /// throws [CacheException]
  WeatherForecastModel fethForecastLocally();
}

class ForecastLocalDatasourceImpl extends ForecastLocalDatasource {
  final SharedPreferences sharedPreferences;
  ForecastLocalDatasourceImpl({required this.sharedPreferences});
  @override
  Future<void> setForecastDataLocally(WeatherForecastModel forecastData) async {
    await sharedPreferences.setString(
        Constants.weatherForecastKey, jsonEncode(forecastData));
  }

  @override
  WeatherForecastModel fethForecastLocally() {
    final response = sharedPreferences.getString(Constants.weatherForecastKey);
    if (response != null) {
      final weatherForecastModel = jsonDecode(response);
      return weatherForecastModel;
    } else {
      throw CacheException();
    }
  }
}
