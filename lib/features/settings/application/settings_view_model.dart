import 'package:flutter/material.dart';
import 'package:weather_flutter/core/enums/app_languages.dart';
import 'package:weather_flutter/core/enums/shared_keys.dart';
import 'package:weather_flutter/core/enums/temperature_unit.dart';
import 'package:weather_flutter/core/util/localization_manager.dart';
import 'package:weather_flutter/core/util/shared_pref_util.dart';

class SettingsViewModel extends ChangeNotifier {
  TemperatureUnit _temperatureUnit = TemperatureUnit.c;
  TemperatureUnit get temperatureUnit => _temperatureUnit;
  AppLanguages _appLanguages = AppLanguages.tr;
  AppLanguages get appLanguages => _appLanguages;

  void updateTemperatureUnit(TemperatureUnit unit) {
    _temperatureUnit = unit;
    _saveTempUnit();
    notifyListeners();
  }

  Future<void> _saveTempUnit() async {
    await SharedPrefUtil.setString(sharedKeys: SharedKeys.tempUnit, value: _temperatureUnit.name);
  }

  void getTempUnit() {
    _temperatureUnit = TemperatureUnit.values.byName(SharedPrefUtil.getString(sharedKeys: SharedKeys.tempUnit) ?? TemperatureUnit.c.name);
    notifyListeners();
  }

  void updateAppLanguage({required AppLanguages languages, required BuildContext context}) {
    _appLanguages = languages;
    _saveAppLanguages(context);
    notifyListeners();
  }

  Future<void> _saveAppLanguages(BuildContext context) async {
    SharedPrefUtil.setString(sharedKeys: SharedKeys.lang, value: _appLanguages.name);
    await LocalizationManager.instance.changeLanguage(context, Locale(_appLanguages.name));
  }

  void getAppLanguages() {
    _appLanguages = AppLanguages.values.byName(SharedPrefUtil.getString(sharedKeys: SharedKeys.lang) ?? AppLanguages.en.name);
    notifyListeners();
  }
}
