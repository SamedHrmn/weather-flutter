// ignore_for_file: must_be_immutable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_flutter/core/components/base/base_icon_button.dart';
import 'package:weather_flutter/core/components/base/empty_box.dart';
import 'package:weather_flutter/core/components/custom/weather_loading_indicator.dart';
import 'package:weather_flutter/core/components/custom/weather_text.dart';
import 'package:weather_flutter/core/constants/color_constant.dart';
import 'package:weather_flutter/core/enums/font_weights.dart';
import 'package:weather_flutter/core/enums/weather_interpretation_codes.dart';
import 'package:weather_flutter/core/util/date_formatter.dart';
import 'package:weather_flutter/core/util/size_helper.dart';
import 'package:weather_flutter/features/weather/presentation/widget/weather_card.dart';

import '../../../core/enums/localization_keys.dart';
import '../../settings/application/settings_view_model.dart';
import '../application/weather_state.dart';
import '../application/weather_viewmodel.dart';
import 'widget/selectable_city_bottom_sheet.dart';

part 'widget/current_weather.dart';
part 'widget/daily_weather.dart';
part 'widget/hourly_weather.dart';

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
