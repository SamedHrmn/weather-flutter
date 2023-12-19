import 'package:flutter/material.dart';
import 'package:weather_flutter/core/components/base/base_text.dart';
import 'package:weather_flutter/core/enums/font_weights.dart';
import 'package:weather_flutter/core/gen/fonts.gen.dart';

class WeatherText extends StatelessWidget {
  const WeatherText({super.key, required this.text, this.weatherTextWeight = WeatherTextWeight.regular, required this.size, this.color});

  final String text;
  final WeatherTextWeight weatherTextWeight;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return BaseText(
      text: text,
      fontFamily: FontFamily.roboto,
      fontWeight: weatherTextWeight.toWeight,
      size: size,
      color: color,
    );
  }
}
