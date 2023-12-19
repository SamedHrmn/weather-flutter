import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_flutter/core/enums/localization_keys.dart';
import 'package:weather_flutter/core/enums/weather_api_uri.dart';
import 'package:weather_flutter/core/enums/weather_interpretation_codes.dart';
import 'package:weather_flutter/core/gen/assets.gen.dart';
import 'package:weather_flutter/core/util/geo_model.dart';
import 'package:weather_flutter/core/util/location_helper.dart';
import 'package:weather_flutter/features/weather/application/weather_state.dart';
import 'package:weather_flutter/features/weather/data/i_weather_repository.dart';

final class WeatherViewModel extends ChangeNotifier {
  final IWeatherRepository weatherRepository;

  WeatherViewModel({required this.weatherRepository});

  WeatherState _dailyWeatherState = const WeatherState(error: null, weatherModel: null, weatherFetchStatus: WeatherFetchStatus.initial);
  WeatherState get dailyWeatherState => _dailyWeatherState;

  WeatherState _hourlyWeatherState = const WeatherState(error: null, weatherModel: null, weatherFetchStatus: WeatherFetchStatus.initial);
  WeatherState get hourlyWeatherState => _hourlyWeatherState;

  GeoModel? _selectedChangableGeo;
  GeoModel? get selectedChangableGeo => _selectedChangableGeo;

  void updateSelectedChangableGeo(int itemIndex) {
    _selectedChangableGeo = selectableCitiesGeo[itemIndex];
    notifyListeners();
  }

  final List<GeoModel> selectableCitiesGeo = [
    GeoModel(lat: 39.925533, long: 32.866287),
    GeoModel(lat: 41.015137, long: 28.979530),
    GeoModel(lat: 40.730610, long: -73.935242),
    GeoModel(lat: 48.85341, long: 2.3488),
    GeoModel(lat: 45.508888, long: -73.561668),
    GeoModel(lat: 47.751076, long: -120.740135),
    GeoModel(lat: 31.000000, long: -100.000000),
  ];

  void updateDailyWeatherState(WeatherState weatherState) {
    _dailyWeatherState = weatherState;
    notifyListeners();
  }

  void updateHourlyWeatherState(WeatherState weatherState) {
    _hourlyWeatherState = weatherState;
    notifyListeners();
  }

  Future<void> getDailyWeather({required GeoModel geoModel}) async {
    try {
      updateDailyWeatherState(const WeatherState(weatherFetchStatus: WeatherFetchStatus.loading, weatherModel: null, error: null, cityName: null));
      final response = await weatherRepository.getWeather(lat: geoModel.lat.toString(), long: geoModel.long.toString(), weatherApiUri: WeatherApiUri.daily);
      if (response != null) {
        final cityName = await LocationHelper.cityNameFromCoordinates(geoModel.lat, geoModel.long);
        updateDailyWeatherState(WeatherState(weatherFetchStatus: WeatherFetchStatus.success, weatherModel: response, error: null, cityName: cityName));
        return;
      } else {
        updateDailyWeatherState(const WeatherState(weatherFetchStatus: WeatherFetchStatus.failure, weatherModel: null, error: '', cityName: null));
      }
    } catch (e) {
      log(e.toString());
      updateDailyWeatherState(const WeatherState(weatherFetchStatus: WeatherFetchStatus.failure, weatherModel: null, error: null, cityName: null));
    }
  }

  Future<void> getHourlyWeather({required GeoModel geoModel}) async {
    try {
      updateHourlyWeatherState(const WeatherState(weatherFetchStatus: WeatherFetchStatus.loading, weatherModel: null, error: null, cityName: null));
      final response = await weatherRepository.getWeather(lat: geoModel.lat.toString(), long: geoModel.long.toString(), weatherApiUri: WeatherApiUri.hourly);
      if (response != null) {
        updateHourlyWeatherState(WeatherState(weatherFetchStatus: WeatherFetchStatus.success, weatherModel: response, error: null, cityName: null));
        return;
      } else {
        updateHourlyWeatherState(const WeatherState(weatherFetchStatus: WeatherFetchStatus.failure, weatherModel: null, error: '', cityName: null));
      }
    } catch (e) {
      log(e.toString());
      updateHourlyWeatherState(const WeatherState(weatherFetchStatus: WeatherFetchStatus.failure, weatherModel: null, error: null, cityName: null));
    }
  }

  String getWeatherIconFromWMO(WMOWeather wmoWeather) {
    switch (wmoWeather) {
      case WMOWeather.clearSky:
        return Assets.icon.clearSky.path;
      case WMOWeather.partlyCloud:
        return Assets.icon.partlyCloud.path;
      case WMOWeather.fog:
        return Assets.icon.fog.path;
      case WMOWeather.drizzle:
      case WMOWeather.freezingDrizzle:
        return Assets.icon.drizzle.path;
      case WMOWeather.rain:
      case WMOWeather.freezingRain:
      case WMOWeather.rainShowers:
        return Assets.icon.rain.path;
      case WMOWeather.snowFall:
      case WMOWeather.snowGrains:
      case WMOWeather.snowShowers:
        return Assets.icon.snow.path;
      case WMOWeather.thunderstorm:
        return Assets.icon.storm.path;
      default:
        return Assets.icon.partlyCloud.path;
    }
  }

  LocalizationKeys getWMOLocalKeys(WMOWeather wmoWeather) {
    switch (wmoWeather) {
      case WMOWeather.clearSky:
        return LocalizationKeys.wmosClearSky;
      case WMOWeather.partlyCloud:
        return LocalizationKeys.wmosPartlyCloud;
      case WMOWeather.fog:
        return LocalizationKeys.wmosFog;
      case WMOWeather.drizzle:
        return LocalizationKeys.wmosDrizzle;
      case WMOWeather.freezingDrizzle:
        return LocalizationKeys.wmosFreezingDrizzle;
      case WMOWeather.rain:
        return LocalizationKeys.wmosRain;
      case WMOWeather.freezingRain:
        return LocalizationKeys.wmosFreezingRain;
      case WMOWeather.rainShowers:
        return LocalizationKeys.wmosRainShowers;
      case WMOWeather.snowFall:
        return LocalizationKeys.wmosSnowFall;
      case WMOWeather.snowGrains:
        return LocalizationKeys.wmosSnowGrains;
      case WMOWeather.snowShowers:
        return LocalizationKeys.wmosSnowShowers;
      case WMOWeather.thunderstorm:
        return LocalizationKeys.wmosThunderstorm;
      default:
        return LocalizationKeys.wmosUnknown;
    }
  }
}
