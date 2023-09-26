import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/weather_forcast/presentation/riverpod/weather_forecast_state.dart';
import 'package:weather_app/features/weather_forcast/presentation/riverpod/weather_provider.dart';
import 'package:weather_app/features/weather_forcast/presentation/ui/forcast_hourly.dart';

import '../../domain/usecases/typed_location_forecast_usecase.dart';
import '../widgets/forecast_card_widget.dart';

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Weather Forecast',
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: _cityController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final readProvider = ref.read(weatherProvifer.notifier);
                        readProvider.getTypedLocationForecast(
                          WeatherParams(
                            cityName: _cityController.text,
                          ),
                        );
                      }
                    },
                  ),
                  hintText: 'Enter city to get city-forecast',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: Consumer(builder: (contex, ref, widget) {
                  final weatherState = ref.watch(weatherProvifer);
                  if (weatherState is ForecastLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (weatherState is ForecastLoadedState) {
                    final time = weatherState.state.hourlyData.time;

                    return ListView.builder(
                      itemCount: time.length,
                      itemBuilder: (context, index) {
                        return time[index].contains('T${DateTime.now().hour}')
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ForecastHourly(
                                        weatherState: weatherState,
                                        time: time[index],
                                      ),
                                    ),
                                  );
                                },
                                child: ForecastCardWidget(
                                  forecastEntity: weatherState.state,
                                  index: index,
                                ),
                              )
                            : const SizedBox();
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('Something went worng!'),
                    );
                  }
                }),
              ),
              ElevatedButton(
                  onPressed: () {
                    currentLocationForecast();
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: const Text(
                      'Current location forecast',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'roboto',
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
