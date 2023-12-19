enum WMOWeather {
  clearSky,
  partlyCloud,
  fog,
  drizzle,
  freezingDrizzle,
  rain,
  freezingRain,
  snowFall,
  snowGrains,
  rainShowers,
  snowShowers,
  thunderstorm,
  unknown;

  static WMOWeather getWMOFromCode(int wmoCode) {
    switch (wmoCode) {
      case 0:
        return WMOWeather.clearSky;
      case 1:
      case 2:
      case 3:
        return WMOWeather.partlyCloud;
      case 45:
      case 48:
        return WMOWeather.fog;
      case 51:
      case 53:
      case 55:
        return WMOWeather.drizzle;
      case 56:
      case 57:
        return WMOWeather.freezingDrizzle;
      case 61:
      case 63:
      case 65:
        return WMOWeather.rain;
      case 66:
      case 67:
        return WMOWeather.freezingRain;
      case 71:
      case 73:
      case 75:
        return WMOWeather.snowFall;
      case 77:
        return WMOWeather.snowGrains;
      case 80:
      case 81:
      case 82:
        return WMOWeather.rainShowers;
      case 85:
      case 86:
        return WMOWeather.snowShowers;
      case 95:
      case 96:
      case 99:
        return WMOWeather.thunderstorm;
      default:
        return WMOWeather.unknown;
    }
  }
}
