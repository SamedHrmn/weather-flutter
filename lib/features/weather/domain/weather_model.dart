import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
final class Weather {
  @JsonKey(name: "latitude")
  final double? latitude;
  @JsonKey(name: "longitude")
  final double? longitude;
  @JsonKey(name: "generationtime_ms")
  final double? generationtimeMs;
  @JsonKey(name: "utc_offset_seconds")
  final num? utcOffsetSeconds;
  @JsonKey(name: "timezone")
  final String? timezone;
  @JsonKey(name: "timezone_abbreviation")
  final String? timezoneAbbreviation;
  @JsonKey(name: "elevation")
  final num? elevation;
  @JsonKey(name: "current_units")
  final CurrentUnits? currentUnits;
  @JsonKey(name: "current")
  final Current? current;
  @JsonKey(name: "daily_units")
  final DailyUnits? dailyUnits;
  @JsonKey(name: "daily")
  final Daily? daily;
  @JsonKey(name: "hourly")
  final Hourly? hourly;

  Weather({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.currentUnits,
    this.current,
    this.dailyUnits,
    this.daily,
    this.hourly,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable()
class Current {
  @JsonKey(name: "time")
  final String? time;
  @JsonKey(name: "interval")
  final num? interval;

  Current({
    this.time,
    this.interval,
  });

  factory Current.fromJson(Map<String, dynamic> json) => _$CurrentFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentToJson(this);
}

@JsonSerializable()
class CurrentUnits {
  @JsonKey(name: "time")
  final String? time;
  @JsonKey(name: "interval")
  final String? interval;

  CurrentUnits({
    this.time,
    this.interval,
  });

  factory CurrentUnits.fromJson(Map<String, dynamic> json) => _$CurrentUnitsFromJson(json);

  Map<String, dynamic> toJson() => _$CurrentUnitsToJson(this);
}

@JsonSerializable()
class Daily {
  @JsonKey(name: "time")
  final List<DateTime>? time;
  @JsonKey(name: "weather_code")
  final List<int>? weatherCode;
  @JsonKey(name: "temperature_2m_max")
  final List<double>? temperature2MMax;
  @JsonKey(name: "temperature_2m_min")
  final List<double>? temperature2MMin;

  Daily({
    this.time,
    this.weatherCode,
    this.temperature2MMax,
    this.temperature2MMin,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => _$DailyFromJson(json);

  Map<String, dynamic> toJson() => _$DailyToJson(this);
}

@JsonSerializable()
class Hourly {
  @JsonKey(name: "time")
  final List<DateTime>? time;
  @JsonKey(name: "weather_code")
  final List<int>? weatherCode;
  @JsonKey(name: "temperature_2m")
  final List<double>? temperature2m;

  Hourly({
    this.time,
    this.weatherCode,
    this.temperature2m,
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => _$HourlyFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyToJson(this);
}

@JsonSerializable()
class DailyUnits {
  @JsonKey(name: "time")
  final String? time;
  @JsonKey(name: "weather_code")
  final String? weatherCode;
  @JsonKey(name: "temperature_2m_max")
  final String? temperature2MMax;
  @JsonKey(name: "temperature_2m_min")
  final String? temperature2MMin;

  DailyUnits({
    this.time,
    this.weatherCode,
    this.temperature2MMax,
    this.temperature2MMin,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) => _$DailyUnitsFromJson(json);

  Map<String, dynamic> toJson() => _$DailyUnitsToJson(this);
}
