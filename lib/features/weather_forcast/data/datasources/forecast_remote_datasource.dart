import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:weather_app/core/erros/exceptions.dart';
import 'package:weather_app/core/utils/constants.dart';
import 'package:weather_app/features/weather_forcast/data/datasources/forecast_local_datasource.dart';
import 'package:weather_app/features/weather_forcast/data/models/weather_forecast_model.dart';
import 'package:weather_app/features/weather_forcast/domain/usecases/typed_location_forecast_usecase.dart';

import '../models/location_data_model.dart';

abstract class ForecastRemoteDatasource {
  ///fetches weather forecast data from
  ///"https://api.open-meteo.com/v1/forecast?hourly=temperature_2m,precipitation,rain,showers&current_weather=true&latitude={latitude}&longitude={longitude}"
  ///throws [ServerException] in case data not fetched.
  Future<WeatherForecastModel> fetchForecastRemotely(LocationDataModel params);

  ///fetches location data from
  ///"https://api.api-ninjas.com/v1/geocoding?city={params.cityName}"
  ///throws [ServerException] in case data not fetched.
  Future<LocationDataModel> fetchTypedLocationData(WeatherParams params);
}

class ForecastRemoteDatasourceImpl extends ForecastRemoteDatasource {
  final Client httpClient;
  final ForecastLocalDatasource localDatasource;
  ForecastRemoteDatasourceImpl({
    required this.httpClient,
    required this.localDatasource,
  });

  @override
  Future<WeatherForecastModel> fetchForecastRemotely(
      LocationDataModel params) async {
    final response = await httpClient.get(
      Uri.parse(
          '${Constants.weatherApiUrl}&longitude=${params.longitude}&latitude=${params.latitude}'),
    );

    print('remote forecast data 1${response.statusCode} ${response.body}');

    if (response.statusCode == 200) {
      final json = await jsonDecode(response.body);
      print('remote forecast data 2  $json');
      final weatherForecastModel = WeatherForecastModel.fromJson(json);
      print('remote forecast data 3 $json');

      await localDatasource.setForecastDataLocally(weatherForecastModel);
      return weatherForecastModel;
    } else {
      print('Error occured in forecast');
      throw ServerException();
    }
  }

  @override
  Future<LocationDataModel> fetchTypedLocationData(WeatherParams params) async {
    final response = await httpClient.get(
        Uri.parse(
          '${Constants.locationApiUrl}?city=${params.cityName}',
        ),
        headers: {
          'X-Api-Key': '5n9LBzHmNfwRNfmpfgSW6w==H5NlQZWILQYP3fQH',
        });

    print('typed location data ${response.body}');

    if (response.statusCode == 200) {
      final json = await jsonDecode(response.body);
      final locationDataModel = LocationDataModel.fromJson(json[0]);

      return locationDataModel;
    } else {
      throw ServerException();
    }
  }
}
