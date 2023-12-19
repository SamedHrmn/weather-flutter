// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter/features/settings/application/settings_view_model.dart';
import 'core/components/custom/weather_scaffold.dart';
import 'core/util/navigator_util.dart';
import 'core/util/permission_util.dart';
import 'features/settings/presentation/settings_view.dart';
import 'features/weather/application/weather_viewmodel.dart';
import 'features/weather/presentation/home_view.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();

    Future.microtask(() async {
      context.read<SettingsViewModel>().getTempUnit();
      context.read<SettingsViewModel>().getAppLanguages();

      final locationInfo = await PermissionUtil.getLocation();
      if (locationInfo.geoModel != null) {
        NavigatorUtil.safeContext.read<WeatherViewModel>().getDailyWeather(geoModel: locationInfo.geoModel!);
        NavigatorUtil.safeContext.read<WeatherViewModel>().getHourlyWeather(geoModel: locationInfo.geoModel!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WeatherScaffold(
      bottomSafe: false,
      child: Stack(
        children: [
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: kToolbarHeight,
              child: ColoredBox(color: Colors.blue),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).viewPadding.bottom + kBottomNavigationBarHeight,
              color: Colors.blue,
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        pageController.jumpToPage(0);
                      },
                      icon: Icon(Icons.home),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        pageController.jumpToPage(1);
                      },
                      icon: Icon(Icons.settings),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: kTextTabBarHeight,
            bottom: MediaQuery.of(context).viewPadding.bottom + kBottomNavigationBarHeight,
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                HomeView(),
                SettingsView(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
