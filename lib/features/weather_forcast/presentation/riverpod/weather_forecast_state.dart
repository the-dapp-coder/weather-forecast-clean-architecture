import 'package:equatable/equatable.dart';
import 'package:weather_app/features/weather_forcast/domain/entities/weather_forecast_entity.dart';

abstract class WeatherForecastState extends Equatable {
  const WeatherForecastState();
}

class ForecastInitialState extends WeatherForecastState {
  @override
  List<Object?> get props => [];
}

class ForecastLoadingState extends WeatherForecastState {
  @override
  List<Object?> get props => [];
}

class ForecastErrorState extends WeatherForecastState {
  @override
  List<Object?> get props => [];
}

class ForecastLoadedState extends WeatherForecastState {
  final WeatherForecastEntity state;
  const ForecastLoadedState({required this.state});

  @override
  List<Object?> get props => [state];
}
