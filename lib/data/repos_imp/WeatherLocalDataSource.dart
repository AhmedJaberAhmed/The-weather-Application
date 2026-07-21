import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/WeatherModel.dart';

class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

abstract class WeatherLocalDataSource {
  Future<void> cacheWeather(WeatherModel model);
  Future<WeatherModel> getLastWeather();
}

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  static const String cacheKey = 'CACHED_WEATHER';
  final SharedPreferences sharedPreferences;

  WeatherLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> cacheWeather(WeatherModel model) {
    return sharedPreferences.setString(cacheKey, jsonEncode(model.toJson()));
  }

  @override
  Future<WeatherModel> getLastWeather() async {
    final jsonString = sharedPreferences.getString(cacheKey);
    if (jsonString == null) {
      throw CacheException('No cached weather data found');
    }
    return WeatherModel.fromCacheJson(jsonDecode(jsonString));
  }
}