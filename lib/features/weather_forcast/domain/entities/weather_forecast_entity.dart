import 'package:equatable/equatable.dart';

class WeatherForecastEntity extends Equatable {
  final double longitude;
  final double latitude;
  final DateTime generatedTimeMs;
  final int utcOffsetSeconds;
  final String timeZone;
  final String timeZoneAbr;
  final double elevation;
  final CurrentWeather currentWeather;
  final WeatherParamUnits weatherParamUnits;
  final HourlyForcastData hourlyData;

  const WeatherForecastEntity({
    required this.longitude,
    required this.latitude,
    required this.generatedTimeMs,
    required this.utcOffsetSeconds,
    required this.timeZone,
    required this.timeZoneAbr,
    required this.elevation,
    required this.currentWeather,
    required this.weatherParamUnits,
    required this.hourlyData,
  });

  @override
  List<Object?> get props => [
        longitude,
        latitude,
        generatedTimeMs,
        utcOffsetSeconds,
        timeZone,
        timeZoneAbr,
        elevation,
        currentWeather,
        weatherParamUnits,
        hourlyData,
      ];
}

class HourlyForcastData extends Equatable {
  final List<DateTime> time;
  final List<double> temperature;
  final List<double> precipitation;
  final List<double> rain;
  final List<double> showers;
  const HourlyForcastData({
    required this.time,
    required this.temperature,
    required this.precipitation,
    required this.rain,
    required this.showers,
  });

  @override
  List<Object?> get props => [
        time,
        temperature,
        precipitation,
        rain,
        showers,
      ];
}

class WeatherParamUnits extends Equatable {
  final String temperature;
  final String precipitation;
  final String rain;
  final String showers;

  const WeatherParamUnits({
    required this.temperature,
    required this.precipitation,
    required this.rain,
    required this.showers,
  });

  @override
  List<Object?> get props => [
        temperature,
        precipitation,
        rain,
        showers,
      ];
}

class CurrentWeather extends Equatable {
  final double temperature;
  final double windspeed;
  final double windDirection;
  final double weatherCode;
  final int isDay;
  final DateTime time;
  const CurrentWeather({
    required this.temperature,
    required this.windspeed,
    required this.windDirection,
    required this.weatherCode,
    required this.isDay,
    required this.time,
  });

  @override
  List<Object?> get props => [
        temperature,
        windspeed,
        windDirection,
        weatherCode,
        isDay,
        time,
      ];
}
