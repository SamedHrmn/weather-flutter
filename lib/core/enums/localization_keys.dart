enum LocalizationKeys {
  homeHourlyWeather("home.hourlyWeather"),
  homeDailyWeather("home.dailyWeather"),
  homeNow("home.now"),
  homeToday("home.today"),
  settingsSettings("settings.settings"),
  settingsUnit("settings.unit"),
  settingsLanguage("settings.lang"),
  daysMonday("days.monday"),
  daysTuesday("days.tuesday"),
  daysWednesday("days.wednesday"),
  daysThursday("days.thursday"),
  daysFriday("days.friday"),
  daysSaturday("days.saturday"),
  daysSunday("days.sunday"),
  daysToday("days.today"),
  wmosClearSky("wmos.clearSky"),
  wmosPartlyCloud("wmos.partlyCloud"),
  wmosFog("wmos.fog"),
  wmosDrizzle("wmos.drizzle"),
  wmosFreezingDrizzle("wmos.freezingDrizzle"),
  wmosRain("wmos.rain"),
  wmosFreezingRain("wmos.freezingRain"),
  wmosSnowFall("wmos.snowFall"),
  wmosSnowGrains("wmos.snowGrains"),
  wmosRainShowers("wmos.rainShower"),
  wmosSnowShowers("wmos.snowShowers"),
  wmosThunderstorm("wmos.thunderStorm"),
  wmosUnknown("wmos.unknown");

  final String localKey;

  const LocalizationKeys(this.localKey);
}
