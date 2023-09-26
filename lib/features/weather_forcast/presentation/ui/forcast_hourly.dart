import 'package:flutter/material.dart';

import '../riverpod/weather_forecast_state.dart';
import '../widgets/forecast_card_widget.dart';

class ForecastHourly extends StatelessWidget {
  final ForecastLoadedState weatherState;
  final String time;
  const ForecastHourly({
    super.key,
    required this.weatherState,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final hourlyData = weatherState.state.hourlyData;
    final units = weatherState.state.weatherParamUnits;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hourly Forecast'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: hourlyData.time.length,
          itemBuilder: (context, index) {
            return hourlyData.time[index].contains(time.split('T')[0])
                ? ForecastCardWidget(
                    hourlyData: hourlyData,
                    index: index,
                    units: units,
                  )
                : const SizedBox();
          },
        ),
      ),
    );
  }
}
