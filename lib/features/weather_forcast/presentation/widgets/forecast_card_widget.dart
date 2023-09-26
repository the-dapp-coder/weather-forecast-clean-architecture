import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';
import '../../domain/entities/weather_forecast_entity.dart';

class ForecastCardWidget extends StatelessWidget {
  final WeatherForecastEntity forecastEntity;
  final int index;
  const ForecastCardWidget({
    super.key,
    required this.forecastEntity,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final hourlyData = forecastEntity.hourlyData;
    final units = forecastEntity.weatherParamUnits;
    return Card(
      color: const Color.fromARGB(255, 250, 247, 239),
      child: Container(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${hourlyData.time[index]}',
              style: Constants.titleTextBold,
            ),
            Text(
              'Time-Zone: ${forecastEntity.timeZone}',
              style: Constants.normalTextBold,
            ),
            Text(
              'Latitude: ${forecastEntity.latitude} | Longitude: ${forecastEntity.longitude}',
              style: Constants.normalTextBlack,
            ),
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
        Text(
          first,
          style: Constants.normalTextColored(textColor: Colors.orange),
        ),
        Text(
          last,
          style: Constants.normalTextColored(textColor: Colors.blue.shade900),
        ),
      ],
    );
  }
}
