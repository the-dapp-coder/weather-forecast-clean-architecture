import 'package:flutter/material.dart';

import '../../domain/entities/weather_forecast_entity.dart';

class ForecastCardWidget extends StatelessWidget {
  final HourlyForcastData hourlyData;
  final WeatherParamUnits units;
  final int index;
  const ForecastCardWidget({
    super.key,
    required this.hourlyData,
    required this.units,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('${hourlyData.time[index]}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _textAlignedColumn(
                  first:
                      'Temp: ${hourlyData.temperature[index]} ${units.temperature}',
                  last:
                      'Showers: ${hourlyData.showers[index]} ${units.showers}',
                ),
                _textAlignedColumn(
                  first:
                      'Precipitation: ${hourlyData.precipitation[index]} ${units.precipitation}',
                  last: 'Rain: ${hourlyData.rain[index]} ${units.rain}',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _textAlignedColumn({
    required String first,
    required String last,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(first),
        Text(last),
      ],
    );
  }
}
