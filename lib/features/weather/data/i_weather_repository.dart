import 'package:weather_flutter/core/enums/weather_api_uri.dart';

import '../domain/weather_model.dart';

abstract interface class IWeatherRepository {
  Future<Weather?> getWeather({required String lat, required String long, required WeatherApiUri weatherApiUri});
}
