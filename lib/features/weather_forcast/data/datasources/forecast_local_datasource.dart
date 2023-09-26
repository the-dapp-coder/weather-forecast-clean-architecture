import 'package:weather_app/features/weather_forcast/data/models/weather_forecast_model.dart';

abstract class ForecastLocalDatasource {
  Future<void> setForecastDataLocally(WeatherForecastModel forecastData);
  Future<WeatherForecastModel> fethForecastLocally(String weatherForecastKey);
}

class ForecastLocalDatasourceImpl extends ForecastLocalDatasource {
  @override
  Future<void> setForecastDataLocally(WeatherForecastModel forecastData) {
    throw UnimplementedError();
  }

  @override
  Future<WeatherForecastModel> fethForecastLocally(String weatherForecastKey) {
    throw UnimplementedError();
  }
}
