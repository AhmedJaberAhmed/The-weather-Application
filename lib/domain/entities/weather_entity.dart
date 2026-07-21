class WeatherEntity {
  final String cityName;
  final double tempC;
  final String condition;
  final String iconUrl;

  const WeatherEntity({
    required this.cityName,
    required this.tempC,
    required this.condition,
    required this.iconUrl,
  });
}