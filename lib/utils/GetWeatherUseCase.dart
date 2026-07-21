

import '../domain/entities/weather_entity.dart';
import '../domain/repos/WeatherRepository.dart';

class GetWeatherUseCase {
  final WeatherRepository repository;

  GetWeatherUseCase(this.repository);

  Future<WeatherEntity> call(String city) {
    return repository.getCurrentWeather(city);
  }
}