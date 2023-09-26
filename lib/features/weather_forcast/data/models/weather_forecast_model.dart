import 'package:weather_app/features/weather_forcast/domain/entities/weather_forecast_entity.dart';

class WeatherForecastModel extends WeatherForecastEntity {
  const WeatherForecastModel({
    required super.longitude,
    required super.latitude,
    required super.generatedTimeMs,
    required super.utcOffsetSeconds,
    required super.timeZone,
    required super.timeZoneAbr,
    required super.elevation,
    required super.currentWeather,
    required super.weatherParamUnits,
    required super.hourlyData,
  });

  factory WeatherForecastModel.fromJson(Map<String, dynamic> json) {
    return WeatherForecastModel(
      longitude: json['longitude'],
      latitude: json['latitude'],
      generatedTimeMs: json['generationtime_ms'],
      utcOffsetSeconds: json['utc_offset_seconds'],
      timeZone: json['timezone'],
      timeZoneAbr: json['timezone_abbreviation'],
      elevation: json['elevation'],
      currentWeather: CurrentWeatherModel.fromJson(json['current_weather']),
      weatherParamUnits: WeatherParamUnitsModel.fromJson(json['hourly_units']),
      hourlyData: HourlyForcastDataModel.fromJson(json['hourly']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
      'generationtime_ms': generatedTimeMs,
      'utc_offset_seconds': utcOffsetSeconds,
      'timezone': timeZone,
      'timezone_abbreviation': timeZoneAbr,
      'elevation': elevation,
      'current_weather': (currentWeather as CurrentWeatherModel).toJson(),
      'hourly_units': (weatherParamUnits as WeatherParamUnitsModel).toJson(),
      'hourly': (hourlyData as HourlyForcastDataModel).toJson(),
    };
  }
}

class HourlyForcastDataModel extends HourlyForcastData {
  const HourlyForcastDataModel({
    required super.time,
    required super.temperature,
    required super.precipitation,
    required super.rain,
    required super.showers,
  });

  factory HourlyForcastDataModel.fromJson(Map<String, dynamic> json) {
    return HourlyForcastDataModel(
      time: json['time'],
      temperature: json['temperature_2m'],
      precipitation: json['precipitation'],
      rain: json['rain'],
      showers: json['showers'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m': temperature,
      'precipitation': precipitation,
      'rain': rain,
      'showers': showers,
    };
  }
}

class WeatherParamUnitsModel extends WeatherParamUnits {
  const WeatherParamUnitsModel({
    required super.temperature,
    required super.precipitation,
    required super.rain,
    required super.showers,
  });

  factory WeatherParamUnitsModel.fromJson(Map<String, dynamic> json) {
    return WeatherParamUnitsModel(
      temperature: json['temperature_2m'],
      precipitation: json['precipitation'],
      rain: json['rain'],
      showers: json['showers'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'temperature_2m': temperature,
      'precipitation': precipitation,
      'rain': rain,
      'showers': showers,
    };
  }
}

class CurrentWeatherModel extends CurrentWeather {
  const CurrentWeatherModel({
    required super.temperature,
    required super.windspeed,
    required super.windDirection,
    required super.weatherCode,
    required super.isDay,
    required super.time,
  });
  factory CurrentWeatherModel.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      temperature: json['temperature'],
      windspeed: json['windspeed'],
      windDirection: json['winddirection'],
      weatherCode: json['weathercode'],
      isDay: json['is_day'],
      time: json['time'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'windspeed': windspeed,
      'winddirection': windDirection,
      'weathercode': weatherCode,
      'is_day': isDay,
      'time': time,
    };
  }
}
