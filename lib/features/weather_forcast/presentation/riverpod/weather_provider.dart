import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/utils/utils.dart';
import 'package:weather_app/features/weather_forcast/domain/usecases/current_location_forecast_usecase.dart';
import 'package:weather_app/features/weather_forcast/domain/usecases/typed_location_forecast_usecase.dart';
import 'package:weather_app/features/weather_forcast/presentation/riverpod/weather_forecast_state.dart';

import '../../../../core/erros/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../injection_container.dart';

final weatherProvifer =
    StateNotifierProvider<WeatherProvider, WeatherForecastState>(
  (ref) => getIt<WeatherProvider>(),
);

class WeatherProvider extends StateNotifier<WeatherForecastState> {
  final CurrentLocationForecastUsecase currentLocationForecastUsecase;
  final TypedLocationForecastUsecase typedLocationForecastUsecase;

  WeatherProvider({
    required this.currentLocationForecastUsecase,
    required this.typedLocationForecastUsecase,
  }) : super(ForecastInitialState());

  void getCurrentLocationForecast() async {
    state = ForecastLoadingState();
    final forecast = await currentLocationForecastUsecase(Params());
    forecast.fold(
      (failure) {
        state = ForecastErrorState();
        _handleFailures(failure);
        print(failure);
      },
      (result) {
        state = ForecastLoadedState(state: result);
      },
    );
  }

  void getTypedLocationForecast(WeatherParams params) async {
    state = ForecastLoadingState();
    final forecast = await typedLocationForecastUsecase(params);
    forecast.fold(
      (failure) {
        state = ForecastErrorState();
        _handleFailures(failure);
        print(failure);
      },
      (result) {
        state = ForecastLoadedState(state: result);
      },
    );
  }

  void _handleFailures(Failures failure) {
    switch (failure) {
      case ServerFailure():
        showErrorToast(message: 'Server Problem: try again later!');
        break;
      case CacheFailure():
        showErrorToast(message: 'Cache Problem: try again later!');
        break;
      case InternetConnectionFailure():
        showErrorToast(message: 'Internet Problem: try again later!');
        break;
      case PermissionBlockedFailure():
        showErrorToast(
            message:
                'Location permission blocked: please enable location & try again!');
        break;
      case PermissionBlockedForeverFailure():
        showErrorToast(
            message:
                'permenant location  permission blocked: please enable location & try again!');
        break;
      case LocationServiceDisabledFailure():
        showErrorToast(message: 'disabled location: please enable location!');
        break;
      default:
    }
  }
}
