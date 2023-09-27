import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/erros/exceptions.dart';
import 'package:weather_app/core/utils/constants.dart';
import 'package:weather_app/features/weather_forcast/data/models/location_data_model.dart';
import 'package:weather_app/features/weather_forcast/data/models/weather_forecast_model.dart';

abstract class ForecastLocalDatasource {
  ///sets weather forecast data to local storage
  Future<void> setForecastDataLocally(WeatherForecastModel forecastData);

  /// fetches weather forecast data from local storage
  /// throws [CacheException]
  WeatherForecastModel fethForecastLocally();

  Future<LocationDataModel> getCurrentLocation();
}

class ForecastLocalDatasourceImpl extends ForecastLocalDatasource {
  final SharedPreferences sharedPreferences;
  ForecastLocalDatasourceImpl({
    required this.sharedPreferences,
  });
  @override
  Future<void> setForecastDataLocally(WeatherForecastModel forecastData) async {
    await sharedPreferences.setString(
        Constants.weatherForecastKey, jsonEncode(forecastData.toJson()));
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

  @override
  Future<LocationDataModel> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Permission denied 1');
        // throw PermissionBlockedException();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.requestPermission();
      print('Permission denied 2');
      // throw PermissionBlockedForeverException();
    }

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Permission denied 3');
      // throw const LocationServiceDisabledException();
    }

    final locationData = await Geolocator.getCurrentPosition();
    final locationModel = LocationDataModel(
      latitude: locationData.latitude,
      longitude: locationData.longitude,
    );
    print('Current Location ${locationModel}');
    return locationModel;
  }
}
