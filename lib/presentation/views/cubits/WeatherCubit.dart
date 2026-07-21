import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repos_imp/WeatherRemoteDataSource.dart';
 import '../../../utils/GetWeatherUseCase.dart';
import '../../../utils/GetCachedWeatherUseCase.dart';
import 'weather_cubit/weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final GetWeatherUseCase getWeatherUseCase;
  final GetCachedWeatherUseCase getCachedWeatherUseCase;

  WeatherCubit(this.getWeatherUseCase, this.getCachedWeatherUseCase)
      : super(WeatherInitial()) {
    _loadCachedWeather();
  }

  Future<void> _loadCachedWeather() async {
    final cached = await getCachedWeatherUseCase();
    if (cached == null) return;

    emit(WeatherLoaded(cached, isOffline: true));

    try {
      final fresh = await getWeatherUseCase(cached.cityName);
      emit(WeatherLoaded(fresh));
    } catch (_) {
     }
  }

  Future<void> fetchWeather(String city) async {
    if (city.trim().isEmpty) {
      emit(const WeatherError('Please enter a city name'));
      return;
    }
    emit(WeatherLoading());
    try {
      final weather = await getWeatherUseCase(city);
      emit(WeatherLoaded(weather));
    } on InvalidCityException catch (e) {
      emit(WeatherError(e.message));
    } on ConnectionException catch (e) {
      final cached = await getCachedWeatherUseCase();
      if (cached != null) {
        emit(WeatherLoaded(cached, isOffline: true));
      } else {
        emit(WeatherError(e.message));
      }
    } catch (e) {
      emit(const WeatherError('Something went wrong'));
    }
  }
}