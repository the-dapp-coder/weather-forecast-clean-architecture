import 'package:dartz/dartz.dart';
import 'package:weather_app/core/erros/failures.dart';
import 'package:weather_app/features/weather_forcast/domain/entities/weather_forecast_entity.dart';

import '../usecases/typed_location_forecast_usecase.dart';

abstract class WetherForecastRepository {
  Future<Either<Failures, WeatherForecastEntity>>
      fetchCurrentLocationForecastData();
  Future<Either<Failures, WeatherForecastEntity>>
      fetchTypedLocationForecastData(WeatherParams params);
}
