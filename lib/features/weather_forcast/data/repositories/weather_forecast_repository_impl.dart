import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weather_app/core/erros/exceptions.dart';

import 'package:weather_app/core/erros/failures.dart';
import 'package:weather_app/core/utils/utils.dart';
import 'package:weather_app/features/weather_forcast/data/datasources/forecast_local_datasource.dart';
import 'package:weather_app/features/weather_forcast/data/datasources/forecast_remote_datasource.dart';

import 'package:weather_app/features/weather_forcast/domain/entities/weather_forecast_entity.dart';

import '../../domain/repositories/weather_forecast_repository.dart';
import '../../domain/usecases/typed_location_forecast_usecase.dart';
import '../models/location_data_model.dart';

typedef LocationHelper = Future<LocationDataModel> Function();

class WeatherForecastRepositoryImpl extends WeatherForecastRepository {
  final InternetConnection internetConnection;
  final ForecastRemoteDatasource remoteDatasource;
  final ForecastLocalDatasource localDatasource;
  WeatherForecastRepositoryImpl({
    required this.internetConnection,
    required this.remoteDatasource,
    required this.localDatasource,
  });
  @override
  Future<Either<Failures, WeatherForecastEntity>>
      fetchCurrentLocationForecastData() async {
    return fetchForecastHelper(
        () async => await localDatasource.getCurrentLocation());
  }

  @override
  Future<Either<Failures, WeatherForecastEntity>>
      fetchTypedLocationForecastData(WeatherParams params) async {
    return fetchForecastHelper(
        () async => await remoteDatasource.fetchTypedLocationData(params));
  }

  Future<Either<Failures, WeatherForecastEntity>> fetchForecastHelper(
      LocationHelper locationHelper) async {
    try {
      final location = await locationHelper();

      if (await internetConnection.hasInternetAccess) {
        final data = await remoteDatasource.fetchForecastRemotely(location);
        return Right(data);
      } else {
        showErrorToast(message: "No internet connection!");
        final data = localDatasource.fethForecastLocally();
        return Right(data);
      }
    } on PermissionBlockedException {
      return Left(PermissionBlockedFailure());
    } on PermissionBlockedForeverException {
      return Left(PermissionBlockedForeverFailure());
    } on LocationServiceDisabledException {
      return Left(LocationServiceDisabledFailure());
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    } catch (err) {
      print('the error is ${err}');
      return Left(UnknownFailure());
    }
  }
}
