// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_flutter/core/components/custom/weather_navbar_button.dart';
import 'package:weather_flutter/core/constants/color_constant.dart';
import 'package:weather_flutter/core/enums/app_navbar_pages.dart';
import 'package:weather_flutter/core/util/size_helper.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeHelper.init(context);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
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
            child: _AppBar(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _BottomNavBar(pageController: pageController),
          ),
          Positioned.fill(
            top: kTextTabBarHeight,
            bottom: MediaQuery.of(context).viewPadding.bottom + kBottomNavigationBarHeight,
            child: _PageView(pageController: pageController),
          )
        ],
      ),
    );
  }
}

class _PageView extends StatelessWidget {
  const _PageView({
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        HomeView(),
        SettingsView(),
      ],
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: MediaQuery.of(context).viewPadding.bottom + kBottomNavigationBarHeight,
      color: ColorConstant.primaryColor,
      child: Row(
        children: [
          Expanded(
            child: WeatherNavbarButton(
              page: AppNavbarPages.home,
              onPressed: () {
                pageController.jumpToPage(AppNavbarPages.home.index);
              },
            ),
          ),
          Expanded(
            child: WeatherNavbarButton(
              page: AppNavbarPages.settings,
              onPressed: () {
                pageController.jumpToPage(AppNavbarPages.settings.index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: kToolbarHeight,
      child: ColoredBox(color: ColorConstant.primaryColor),
    );
  }
}
