import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/erros/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather_forcast/domain/entities/weather_forecast_entity.dart';

import '../repositories/weather_forecast_repository.dart';

class TypedLocationForecastUsecase
    extends Usecase<WeatherForecastEntity, WeatherParams> {
  final WeatherForecastRepository repository;
  TypedLocationForecastUsecase({required this.repository});

  @override
  Future<Either<Failures, WeatherForecastEntity>> call(WeatherParams params) {
    return repository.fetchTypedLocationForecastData(params);
  }
}

class WeatherParams extends Equatable {
  final String cityName;
  const WeatherParams({
    required this.cityName,
  });
  @override
  List<Object?> get props => [cityName];
}
