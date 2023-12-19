part of '../home_view.dart';

class _CurrentWeather extends StatelessWidget {
  const _CurrentWeather({required this.weatherViewModel});

  final WeatherViewModel weatherViewModel;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ColorConstant.primaryColor,
      child: Padding(
        padding: EdgeInsets.only(left: SizeHelper.defaultPadding, right: SizeHelper.defaultPadding, bottom: SizeHelper.mediumPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            headerInformation(context),
            Flexible(
              child: wmoImage(),
            )
          ],
        ),
      ),
    );
  }

  Widget headerInformation(BuildContext context) {
    return Column(
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
              BaseIconButton(
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
                iconData: Icons.change_circle,
                iconColor: ColorConstant.generalButtonColor,
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
    );
  }

  Widget wmoImage() {
    return Image.asset(
      weatherViewModel.getWeatherIconFromWMO(
        weatherViewModel.dailyWeatherState.getWMOCurrent(),
      ),
      width: SizeHelper.blockSizeHorizontal * 34,
      fit: BoxFit.cover,
    );
  }
}
