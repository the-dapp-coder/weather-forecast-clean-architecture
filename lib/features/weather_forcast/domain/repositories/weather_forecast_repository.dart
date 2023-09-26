import 'package:dartz/dartz.dart';
import 'package:weather_app/core/erros/failures.dart';
import 'package:weather_app/features/weather_forcast/domain/entities/weather_forecast_entity.dart';
import 'package:weather_app/features/weather_forcast/domain/usecases/fetch_weather_data_usecase.dart';

abstract class WetherForecastRepository {
  Future<Either<Failures, WeatherForecastEntity>> fetchForecastData(
      WeatherParams params);
}
