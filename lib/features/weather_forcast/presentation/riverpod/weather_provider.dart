import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/weather_forcast/domain/usecases/current_location_forecast_usecase.dart';
import 'package:weather_app/features/weather_forcast/domain/usecases/typed_location_forecast_usecase.dart';
import 'package:weather_app/features/weather_forcast/presentation/riverpod/weather_forecast_state.dart';

import '../../../../injection_container.dart';

final weatherProvifer =
    StateNotifierProvider<WeatherProvider, WeatherForecastState>(
  (ref) => getIt<WeatherProvider>(),
);

class WeatherProvider extends StateNotifier<WeatherForecastState> {
  final CurrentLocationForecastUsecase currentLocationForecastUsecase;
  final TypedLocationForecastUsecase typedLocationForecastUsecase;

  WeatherProvider({
    required this.currentLocationForecastUsecase,
    required this.typedLocationForecastUsecase,
  }) : super(ForecastInitialState());
}
