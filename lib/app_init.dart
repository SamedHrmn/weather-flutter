import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:weather_flutter/core/util/shared_pref_util.dart';

import 'core/util/localization_manager.dart';

final class AppInit {
  AppInit._();

  static Future<void> initWeatherApp() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await Future.wait([
      SharedPrefUtil.initSharedPrefs(),
      LocalizationManager.instance.initLocalization(),
    ]);
    FlutterNativeSplash.remove();
  }
}
