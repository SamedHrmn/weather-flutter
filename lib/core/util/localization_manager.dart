import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationManager {
  const LocalizationManager._();

  static LocalizationManager? _instance;

  static LocalizationManager get instance => _instance ??= const LocalizationManager._();

  Future<void> changeLanguage(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
  }

  Future<void> initLocalization() async {
    await EasyLocalization.ensureInitialized();
  }
}
