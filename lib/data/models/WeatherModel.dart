import '../../domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.cityName,
    required super.tempC,
    required super.condition,
    required super.iconUrl,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final location = json['location'];
    final current = json['current'];
    final condition = current['condition'];
    return WeatherModel(
      cityName: location['name'],
      tempC: (current['temp_c'] as num).toDouble(),
      condition: condition['text'],
      iconUrl: 'https:${condition['icon']}',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'tempC': tempC,
      'condition': condition,
      'iconUrl': iconUrl,
    };
  }

  factory WeatherModel.fromCacheJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['cityName'],
      tempC: (json['tempC'] as num).toDouble(),
      condition: json['condition'],
      iconUrl: json['iconUrl'],
    );
  }
}