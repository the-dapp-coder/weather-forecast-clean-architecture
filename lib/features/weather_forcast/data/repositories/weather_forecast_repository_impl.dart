import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weather_app/core/erros/exceptions.dart';

import 'package:weather_app/core/erros/failures.dart';
import 'package:weather_app/core/utils/utils.dart';
import 'package:weather_app/features/weather_forcast/data/datasources/forecast_local_datasource.dart';
import 'package:weather_app/features/weather_forcast/data/datasources/forecast_remote_datasource.dart';

import 'package:weather_app/features/weather_forcast/domain/entities/weather_forecast_entity.dart';

import 'package:weather_app/features/weather_forcast/domain/usecases/fetch_weather_data_usecase.dart';

import '../../domain/repositories/weather_forecast_repository.dart';

class WetherForecastRepositoryImpl extends WetherForecastRepository {
  final InternetConnection internetConnection;
  final ForecastRemoteDatasource remoteDatasource;
  final ForecastLocalDatasource localDatasource;
  WetherForecastRepositoryImpl({
    required this.internetConnection,
    required this.remoteDatasource,
    required this.localDatasource,
  });
  @override
  Future<Either<Failures, WeatherForecastEntity>> fetchForecastData(
      WeatherParams params) async {
    try {
      if (await internetConnection.hasInternetAccess) {
        final data = await remoteDatasource.fetchForecastRemotely(params);
        return Right(data);
      } else {
        showErrorToast(message: "No internet connection!");
        final data = localDatasource.fethForecastLocally();
        return Right(data);
      }
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    } catch (err) {
      return Left(UnknownFailure());
    }
  }
}
