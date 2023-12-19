import 'package:flutter/material.dart';

enum WeatherTextWeight {
  light,
  regular,
  bold,
  black;

  const WeatherTextWeight();

  FontWeight get toWeight => switch (this) {
        WeatherTextWeight.light => FontWeight.w300,
        WeatherTextWeight.regular => FontWeight.w400,
        WeatherTextWeight.bold => FontWeight.w700,
        WeatherTextWeight.black => FontWeight.w900
      };
}
