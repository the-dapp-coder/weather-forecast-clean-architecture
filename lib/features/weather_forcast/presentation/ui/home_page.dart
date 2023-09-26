import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/weather_forcast/presentation/riverpod/weather_forecast_state.dart';
import 'package:weather_app/features/weather_forcast/presentation/riverpod/weather_provider.dart';

import '../../domain/usecases/typed_location_forecast_usecase.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late TextEditingController _cityController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _cityController = TextEditingController();
    currentLocationForecast();
  }

  @override
  void dispose() {
    super.dispose();
    _cityController.clear();
  }

  void currentLocationForecast() {
    Timer(const Duration(), () {
      final readProvider = ref.read(weatherProvifer.notifier);
      readProvider.getCurrentLocationForecast();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Forecast'),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter city name.';
                  }
                  return null;
                },
                controller: _cityController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Expanded(
                child: Consumer(builder: (contex, ref, widget) {
                  final weatherState = ref.watch(weatherProvifer);
                  if (weatherState is ForecastLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (weatherState is ForecastLoadedState) {
                    return ListView.builder(itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                              '${weatherState.state.hourlyData.temperature[index]}'),
                        ),
                      );
                    });
                  } else {
                    return const Center(
                      child: Text('Something went worng!'),
                    );
                  }
                }),
              ),
              ElevatedButton(
                onPressed: () {
                  final readProvider = ref.read(weatherProvifer.notifier);
                  readProvider.getTypedLocationForecast(
                    WeatherParams(
                      cityName: _cityController.text,
                    ),
                  );
                },
                child: const Text('Fetch Data'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
