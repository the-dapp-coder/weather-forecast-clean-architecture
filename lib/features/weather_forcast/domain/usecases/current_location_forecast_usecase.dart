import 'package:dartz/dartz.dart';
import 'package:weather_app/core/erros/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather_forcast/domain/entities/weather_forecast_entity.dart';

class CurrentLocationForecastUsecase
    extends Usecase<WeatherForecastEntity, Params> {
  @override
  Future<Either<Failures, WeatherForecastEntity>> call(Params params) {
    throw UnimplementedError();
  }
}
