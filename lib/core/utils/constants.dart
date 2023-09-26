import 'package:flutter/material.dart';

class Constants {
  static String weatherForecastKey = 'weather_forecast';

  static String weatherApiUrl =
      'https://api.open-meteo.com/v1/forecast?hourly=temperature_2m,precipitation,rain,showers&current_weather=true&timezone=auto';

  static String locationApiUrl = 'https://api.api-ninjas.com/v1/geocoding';

  static const titleTextBold = TextStyle(
    fontFamily: 'roboto',
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const normalTextBlack = TextStyle(
    fontFamily: 'roboto',
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  static const normalTextBold = TextStyle(
    fontFamily: 'roboto',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle normalTextColored({required Color textColor}) => TextStyle(
        fontFamily: 'roboto',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
      );
}
