import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'package:weather_app/core/erros/failures.dart';

import 'package:weather_app/features/weather_forcast/domain/entities/weather_forecast_entity.dart';

import 'package:weather_app/features/weather_forcast/domain/usecases/fetch_weather_data_usecase.dart';

import '../../domain/repositories/weather_forecast_repository.dart';

class WetherForecastRepositoryImpl extends WetherForecastRepository {
  final InternetConnection internetConnection;
  WetherForecastRepositoryImpl({required this.internetConnection});
  @override
  Future<Either<Failures, WeatherForecastEntity>> fetchForecastData(
      WeatherParams params) async {
    if (await internetConnection.hasInternetAccess) {
      throw UnimplementedError();
    } else {
      return Left(InternetConnectionFailure());
    }
  }
}
