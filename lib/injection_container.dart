import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/features/weather_forcast/data/datasources/forecast_local_datasource.dart';
import 'package:weather_app/features/weather_forcast/data/datasources/forecast_remote_datasource.dart';
import 'package:weather_app/features/weather_forcast/domain/repositories/weather_forecast_repository.dart';
import 'package:weather_app/features/weather_forcast/domain/usecases/current_location_forecast_usecase.dart';
import 'package:weather_app/features/weather_forcast/domain/usecases/typed_location_forecast_usecase.dart';
import 'package:weather_app/features/weather_forcast/presentation/riverpod/weather_provider.dart';
import 'package:http/http.dart' as http;
import 'features/weather_forcast/data/repositories/weather_forecast_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerFactory<WeatherProvider>(
    () => WeatherProvider(
      currentLocationForecastUsecase: getIt(),
      typedLocationForecastUsecase: getIt(),
    ),
  );
  getIt.registerLazySingleton(
      () => CurrentLocationForecastUsecase(repository: getIt()));

  getIt.registerLazySingleton(
      () => TypedLocationForecastUsecase(repository: getIt()));

  getIt.registerLazySingleton<WeatherForecastRepository>(
    () => WeatherForecastRepositoryImpl(
      internetConnection: getIt(),
      localDatasource: getIt(),
      remoteDatasource: getIt(),
    ),
  );

  getIt.registerLazySingleton<ForecastLocalDatasource>(
      () => ForecastLocalDatasourceImpl(sharedPreferences: getIt()));
  getIt.registerLazySingleton<ForecastRemoteDatasource>(() =>
      ForecastRemoteDatasourceImpl(
          httpClient: getIt(), localDatasource: getIt()));

  // plugins

  getIt.registerFactory<InternetConnection>(() => InternetConnection());

  final sharedPref = await SharedPreferences.getInstance();
  getIt.registerFactory<SharedPreferences>(() => sharedPref);
  getIt.registerFactory<Client>(() => http.Client());
}
