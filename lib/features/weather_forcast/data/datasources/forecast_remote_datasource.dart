import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_app/core/erros/exceptions.dart';
import 'package:weather_app/core/utils/constants.dart';
import 'package:weather_app/features/weather_forcast/data/datasources/forecast_local_datasource.dart';
import 'package:weather_app/features/weather_forcast/data/models/weather_forecast_model.dart';
import 'package:weather_app/features/weather_forcast/domain/usecases/fetch_weather_data_usecase.dart';

abstract class ForecastRemoteDatasource {
  ///fetches weather forecast data from
  ///"https://api.open-meteo.com/v1/forecast?hourly=temperature_2m,precipitation,rain,showers&current_weather=true&latitude={latitude}&longitude={longitude}"
  ///throws [ServerException] in case data not fetched.
  Future<WeatherForecastModel> fetchForecastRemotely(WeatherParams params);
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
      WeatherParams params) async {
    final response = await httpClient.get(
      Uri.parse(
          '${Constants.weatherApiUrl}&longitude=${params.longitude}&latitude=${params.latitude}'),
    );

    if (response.statusCode == 200) {
      final weatherForecastModel = WeatherForecastModel.fromJson(
        jsonDecode(response.body),
      );
      await localDatasource.setForecastDataLocally(weatherForecastModel);
      return weatherForecastModel;
    } else {
      throw ServerException();
    }
  }
}
