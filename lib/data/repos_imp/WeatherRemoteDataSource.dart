import 'package:dio/dio.dart';
import '../models/WeatherModel.dart';

class InvalidCityException implements Exception {
  final String message;
  InvalidCityException(this.message);
}

class ConnectionException implements Exception {
  final String message;
  ConnectionException(this.message);
}

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> fetchWeather(String city);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final Dio dio;
  static const String apiKey = '6f27a7b9512c4882a45162444252101';
  static const String baseUrl = 'https://api.weatherapi.com/v1/current.json';

  WeatherRemoteDataSourceImpl(this.dio);

  @override
  Future<WeatherModel> fetchWeather(String city) async {
    try {
      final response = await dio.get(
        baseUrl,
        queryParameters: {
          'key': apiKey,
          'q': city,
        },
      );

      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null && e.response?.statusCode == 400) {
        throw InvalidCityException('City not found');
      }
      throw ConnectionException('Failed to connect. Check your internet connection');
    } catch (e) {
      throw ConnectionException('Unexpected error occurred');
    }
  }
}