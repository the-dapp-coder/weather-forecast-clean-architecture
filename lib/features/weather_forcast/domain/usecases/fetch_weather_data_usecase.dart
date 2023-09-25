import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/erros/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather_forcast/domain/entities/weather_forecast_entity.dart';

class FetchWetherDataUsecase
    extends Usecase<WeatherForecastEntity, WeatherParams> {
  @override
  Future<Either<Failures, WeatherForecastEntity>> call(WeatherParams params) {
    throw UnimplementedError();
  }
}

class WeatherParams extends Equatable {
  final String longitude;
  final String latitude;
  const WeatherParams({
    required this.latitude,
    required this.longitude,
  });
  @override
  List<Object?> get props => [
        longitude,
        latitude,
      ];
}
