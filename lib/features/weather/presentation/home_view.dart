// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter/core/components/custom/weather_loading_indicator.dart';
import 'package:weather_flutter/core/components/custom/weather_text.dart';
import 'package:weather_flutter/core/constants/color_constant.dart';
import 'package:weather_flutter/core/enums/font_weights.dart';
import 'package:weather_flutter/core/enums/weather_interpretation_codes.dart';
import 'package:weather_flutter/core/util/date_formatter.dart';
import '../../../core/enums/localization_keys.dart';
import '../../settings/application/settings_view_model.dart';
import '../application/weather_state.dart';
import '../application/weather_viewmodel.dart';
import 'widget/selectable_city_bottom_sheet.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<WeatherViewModel>(
        builder: (context, weatherViewModel, _) {
          return Column(
            children: [
              _CurrentWeather(
                weatherViewModel: weatherViewModel,
              ),
              _DailyWeather(
                weatherViewModel: weatherViewModel,
              ),
              _HourlyWeather(weatherViewModel: weatherViewModel),
            ],
          );
        },
      ),
    );
  }
}

class _HourlyWeather extends StatelessWidget {
  _HourlyWeather({required this.weatherViewModel}) {
    if (weatherViewModel.hourlyWeatherState.weatherModel != null) {
      int nowIndex = weatherViewModel.hourlyWeatherState.weatherModel!.hourly!.time!.indexWhere((element) => element.hour == DateTime.now().hour);
      hours = weatherViewModel.hourlyWeatherState.weatherModel!.hourly!.time!.sublist(nowIndex);
      wmos = weatherViewModel.hourlyWeatherState.weatherModel!.hourly!.weatherCode!.sublist(nowIndex);
    }
  }

  final WeatherViewModel weatherViewModel;
  late List<DateTime> hours;
  late List<int> wmos;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: WeatherText(
              text: LocalizationKeys.homeHourlyWeather.localKey.tr(context: context),
              size: 20,
              weatherTextWeight: WeatherTextWeight.bold,
              color: ColorConstant.textBlack,
            ),
          ),
        ),
        if (weatherViewModel.hourlyWeatherState.weatherFetchStatus == WeatherFetchStatus.loading || weatherViewModel.hourlyWeatherState.weatherModel == null) ...{
          const WeatherLoadingIndicator(),
        } else ...{
          SizedBox(
            height: 166,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                itemBuilder: (context, index) {
                  return Material(
                    elevation: 8,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: SizedBox(
                      width: 120,
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          WeatherText(text: index == 0 ? LocalizationKeys.homeNow.localKey.tr(context: context) : hours[index].formatTime(), size: 12),
                          Image.asset(
                            weatherViewModel.getWeatherIconFromWMO(
                              weatherViewModel.hourlyWeatherState.getWMOCurrent(),
                            ),
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Consumer<SettingsViewModel>(
                            builder: (context, settingsViewModel, _) =>
                                WeatherText(text: weatherViewModel.hourlyWeatherState.getHourlyTemp(unit: settingsViewModel.temperatureUnit)[index], size: 12),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemCount: hours.length),
          ),
        }
      ],
    );
  }
}

class _DailyWeather extends StatelessWidget {
  const _DailyWeather({required this.weatherViewModel});

  final WeatherViewModel weatherViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: WeatherText(
              text: LocalizationKeys.homeDailyWeather.localKey.tr(context: context),
              size: 20,
              weatherTextWeight: WeatherTextWeight.bold,
              color: ColorConstant.textBlack,
            ),
          ),
        ),
        if (weatherViewModel.dailyWeatherState.weatherFetchStatus == WeatherFetchStatus.loading || weatherViewModel.dailyWeatherState.weatherModel == null) ...{
          const WeatherLoadingIndicator(),
        } else ...{
          SizedBox(
            height: 166,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                itemBuilder: (context, index) {
                  final days = weatherViewModel.dailyWeatherState.weatherModel!.daily!.time!;
                  final wmos = weatherViewModel.dailyWeatherState.weatherModel!.daily!.weatherCode!;

                  return Material(
                    elevation: 8,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: SizedBox(
                      width: 120,
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          WeatherText(text: days[index].weekdayName(todayTextInclude: true)?.localKey.tr(context: context) ?? "", size: 12),
                          Image.asset(
                            weatherViewModel.getWeatherIconFromWMO(
                              weatherViewModel.dailyWeatherState.getWMOCurrent(),
                            ),
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          WeatherText(text: weatherViewModel.getWMOLocalKeys(WMOWeather.getWMOFromCode(wmos[index])).localKey.tr(context: context), size: 12),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 16),
                itemCount: weatherViewModel.dailyWeatherState.weatherModel!.daily!.time!.length),
          ),
        }
      ],
    );
  }
}

class _CurrentWeather extends StatelessWidget {
  const _CurrentWeather({required this.weatherViewModel});

  final WeatherViewModel weatherViewModel;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (weatherViewModel.dailyWeatherState.weatherFetchStatus == WeatherFetchStatus.success) ...{
                  Row(
                    children: [
                      WeatherText(
                        text: weatherViewModel.dailyWeatherState.cityName ?? "",
                        size: 20,
                        color: ColorConstant.textWhite,
                        weatherTextWeight: WeatherTextWeight.bold,
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return const SelectableCityBottomSheet();
                            },
                          ).then((_) {
                            if (weatherViewModel.selectedChangableGeo != null) {
                              Future.microtask(() {
                                weatherViewModel.getDailyWeather(geoModel: weatherViewModel.selectedChangableGeo!);
                              });
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.change_circle,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Consumer<SettingsViewModel>(
                    builder: (context, settingsViewModel, child) => WeatherText(
                      text: weatherViewModel.dailyWeatherState.getCurrentTemp(unit: settingsViewModel.temperatureUnit),
                      size: 48,
                      color: ColorConstant.textWhite,
                      weatherTextWeight: WeatherTextWeight.bold,
                    ),
                  ),
                  WeatherText(
                    text: weatherViewModel.getWMOLocalKeys(weatherViewModel.dailyWeatherState.getWMOCurrent()).localKey.tr(context: context),
                    size: 32,
                    color: ColorConstant.textWhite,
                    weatherTextWeight: WeatherTextWeight.regular,
                  ),
                }
              ],
            ),
            Image.asset(
              weatherViewModel.getWeatherIconFromWMO(
                weatherViewModel.dailyWeatherState.getWMOCurrent(),
              ),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            )
          ],
        ),
      ),
    );
  }
}
