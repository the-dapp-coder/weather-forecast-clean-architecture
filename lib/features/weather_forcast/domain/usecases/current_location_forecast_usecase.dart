import 'package:dartz/dartz.dart';
import 'package:weather_app/core/erros/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather_forcast/domain/entities/weather_forecast_entity.dart';
import 'package:weather_app/features/weather_forcast/domain/repositories/weather_forecast_repository.dart';

class CurrentLocationForecastUsecase
    extends Usecase<WeatherForecastEntity, Params> {
  final WeatherForecastRepository repository;
  CurrentLocationForecastUsecase({required this.repository});
  @override
  Future<Either<Failures, WeatherForecastEntity>> call(Params params) async {
    return await repository.fetchCurrentLocationForecastData();
  }
}
