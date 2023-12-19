import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_flutter/core/enums/shared_keys.dart';

class SharedPrefUtil {
  SharedPrefUtil._();

  static late final SharedPreferences _sharedPreferences;

  static Future<void> initSharedPrefs() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setString({required SharedKeys sharedKeys, required String value}) async {
    await _sharedPreferences.setString(sharedKeys.name, value);
  }

  static String? getString({required SharedKeys sharedKeys}) => _sharedPreferences.getString(sharedKeys.name);
}
