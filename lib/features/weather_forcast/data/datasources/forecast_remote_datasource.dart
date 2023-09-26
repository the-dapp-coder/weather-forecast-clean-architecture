import 'package:weather_app/features/weather_forcast/data/models/weather_forecast_model.dart';
import 'package:weather_app/features/weather_forcast/domain/usecases/fetch_weather_data_usecase.dart';

abstract class ForecastRemoteDatasource {
  Future<WeatherForecastModel> fetchForecastRemotely(WeatherParams params);
}

class ForecastRemoteDatasourceImpl extends ForecastRemoteDatasource {
  @override
  Future<WeatherForecastModel> fetchForecastRemotely(WeatherParams params) {
    throw UnimplementedError();
  }
}
