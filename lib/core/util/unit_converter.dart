mixin UnitConverter {
  static double fahrenheitToCelsius(double fahrenheit) {
    return (5 / 9) * (fahrenheit - 32);
  }

  static double celsiusToFahrenheit(double celsius) {
    return (9 / 5) * celsius + 32;
  }
}
