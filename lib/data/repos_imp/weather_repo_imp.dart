import '../../domain/entities/weather_entity.dart';
 import '../../domain/repos/WeatherRepository.dart';
import 'WeatherLocalDataSource.dart';
import 'WeatherRemoteDataSource.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<WeatherEntity> getCurrentWeather(String city) async {
    final model = await remoteDataSource.fetchWeather(city);
    await localDataSource.cacheWeather(model);
    return model;
  }

  @override
  Future<WeatherEntity?> getLastCachedWeather() async {
    try {
      return await localDataSource.getLastWeather();
    } on CacheException {
      return null;
    }
  }
}