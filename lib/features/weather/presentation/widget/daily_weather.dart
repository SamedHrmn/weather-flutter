part of '../home_view.dart';

class _DailyWeather extends StatelessWidget {
  const _DailyWeather({required this.weatherViewModel});

  final WeatherViewModel weatherViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: SizeHelper.defaultPadding, left: SizeHelper.defaultPadding, right: SizeHelper.defaultPadding),
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
            height: SizeHelper.blockSizeVertical * 23.5,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: SizeHelper.defaultPadding, vertical: SizeHelper.mediumPadding),
                itemBuilder: (context, index) {
                  final days = weatherViewModel.dailyWeatherState.weatherModel!.daily!.time!;
                  final wmos = weatherViewModel.dailyWeatherState.weatherModel!.daily!.weatherCode!;

                  return WeatherCard(
                    child: Column(
                      children: [
                        const EmptyBox(height: 8),
                        WeatherText(text: days[index].weekdayName(todayTextInclude: true)?.localKey.tr(context: context) ?? "", size: 12),
                        Image.asset(
                          weatherViewModel.getWeatherIconFromWMO(
                            weatherViewModel.dailyWeatherState.getWMOCurrent(),
                          ),
                          height: SizeHelper.blockSizeHorizontal * 15,
                          fit: BoxFit.cover,
                        ),
                        const EmptyBox(height: 8),
                        WeatherText(text: weatherViewModel.getWMOLocalKeys(WMOWeather.getWMOFromCode(wmos[index])).localKey.tr(context: context), size: 12),
                        const EmptyBox(height: 8),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => EmptyBox(width: SizeHelper.defaultPadding),
                itemCount: weatherViewModel.dailyWeatherState.weatherModel!.daily!.time!.length),
          ),
        }
      ],
    );
  }
}
