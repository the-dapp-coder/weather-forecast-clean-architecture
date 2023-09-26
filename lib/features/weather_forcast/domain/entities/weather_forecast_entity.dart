import 'package:equatable/equatable.dart';

class WeatherForecastEntity extends Equatable {
  final double longitude;
  final double latitude;
  final double generatedTimeMs;
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
  final List<dynamic> time;
  final List<dynamic> temperature;
  final List<dynamic> precipitation;
  final List<dynamic> rain;
  final List<dynamic> showers;
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
  final int windDirection;
  final int weatherCode;
  final int isDay;
  final String time;
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
