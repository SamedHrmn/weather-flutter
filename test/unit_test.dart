// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:developer';

import 'package:weather_flutter/core/api/dio_api_client.dart';
import 'package:weather_flutter/core/api/i_api_client.dart';
import 'package:weather_flutter/core/enums/weather_api_uri.dart';
import 'package:weather_flutter/features/weather/data/i_weather_repository.dart';
import 'package:weather_flutter/features/weather/domain/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';

class MockWeatherRepository implements IWeatherRepository {
  final IApiClient apiClient;

  MockWeatherRepository({required this.apiClient});

  @override
  Future<Weather?> getWeather({required String lat, required String long, required WeatherApiUri weatherApiUri}) async {
    try {
      final response = await apiClient.fetch<Map<String, dynamic>>(apiUri: weatherApiUri.toUri(lat, long));
      expect(response, isNotNull);
      final model = Weather.fromJson(response!);
      if (weatherApiUri == WeatherApiUri.daily) {
        expect(model.daily, isNotNull, reason: "Daily data is null");
        expect(model.daily?.weatherCode, isNotNull, reason: "Daily weathercode is null");
        expect(model.daily?.time, isNotNull, reason: "Daily time is null");
        expect(model.daily?.temperature2MMin, isNotNull, reason: "Daily tempMin is null");
        expect(model.daily?.temperature2MMax, isNotNull, reason: "Daily tempMax is null");
      } else {
        expect(model.hourly, isNotNull, reason: "Hourly data is null");
        expect(model.hourly?.weatherCode, isNotNull, reason: "Hourly weathercode is null");
        expect(model.hourly?.time, isNotNull, reason: "Hourly time is null");
        expect(model.hourly?.temperature2m, isNotNull, reason: "Horuly temp is null");
      }

      log(model.toJson().toString());

      return model;
    } catch (e) {
      return null;
    }
  }
}

void main() {
  test("Daily Weather Test", () async {
    final mockWeatherRepository = MockWeatherRepository(apiClient: DioApiClient());
    await mockWeatherRepository.getWeather(lat: "39.925533", long: "32.866287", weatherApiUri: WeatherApiUri.daily);
  });

  test("Hourly Weather Test", () async {
    final mockWeatherRepository = MockWeatherRepository(apiClient: DioApiClient());
    await mockWeatherRepository.getWeather(lat: "39.925533", long: "32.866287", weatherApiUri: WeatherApiUri.hourly);
  });
}
