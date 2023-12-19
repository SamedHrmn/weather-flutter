import 'package:weather_flutter/core/enums/localization_keys.dart';

extension DateTimeExtension on DateTime {
  LocalizationKeys? weekdayName({bool todayTextInclude = false}) {
    const Map<int, LocalizationKeys> weekdayName = {
      1: LocalizationKeys.daysMonday,
      2: LocalizationKeys.daysTuesday,
      3: LocalizationKeys.daysWednesday,
      4: LocalizationKeys.daysThursday,
      5: LocalizationKeys.daysFriday,
      6: LocalizationKeys.daysSaturday,
      7: LocalizationKeys.daysSunday
    };
    final day = weekdayName[weekday];
    return weekday == DateTime.now().weekday && todayTextInclude ? LocalizationKeys.daysToday : day;
  }

  String formatTime() {
    int _hour = hour;

    String ampm = _hour < 12 ? 'AM' : 'PM';

    if (_hour > 12) {
      _hour -= 12;
    }

    String formattedHour = _hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');

    return '$formattedHour:$formattedMinute $ampm';
  }
}
