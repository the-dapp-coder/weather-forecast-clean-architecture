import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/weather_forcast/presentation/riverpod/weather_forecast_state.dart';

final weatherProvifer =
    StateNotifierProvider<WeatherProvider, WeatherForecastState>(
  (ref) => WeatherProvider(),
);

class WeatherProvider extends StateNotifier<WeatherForecastState> {
  WeatherProvider() : super(ForecastInitialState());
}
