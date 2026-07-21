import '../domain/entities/weather_entity.dart';
import '../domain/repos/WeatherRepository.dart';

class GetCachedWeatherUseCase {
  final WeatherRepository repository;

  GetCachedWeatherUseCase(this.repository);

  Future<WeatherEntity?> call() {
    return repository.getLastCachedWeather();
  }
}