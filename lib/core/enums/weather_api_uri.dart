enum WeatherApiUri {
  daily,
  hourly;

  const WeatherApiUri();

  static const _baseUrl = "https://api.open-meteo.com";

  Uri toUri(String lat, String long) {
    switch (this) {
      case WeatherApiUri.daily:
      case WeatherApiUri.hourly:
        return Uri.parse(_buildPath(lat, long));
    }
  }

  String _buildPath(String lat, String long) {
    switch (this) {
      case WeatherApiUri.daily:
        return '$_baseUrl/v1/forecast?latitude=$lat&longitude=$long&current=&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto';
      case WeatherApiUri.hourly:
        return '$_baseUrl/v1/forecast?latitude=$lat&longitude=$long&hourly=temperature_2m,weather_code';
    }
  }
}
