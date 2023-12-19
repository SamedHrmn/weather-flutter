import 'package:flutter/material.dart';
import 'package:weather_flutter/core/components/custom/weather_text.dart';

class WeatherRadioTile<T> extends StatelessWidget {
  const WeatherRadioTile({super.key, required this.text, required this.value, required this.groupValue, this.onChanged});

  final String text;
  final T value;
  final T groupValue;
  final void Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: WeatherText(
        text: text,
        size: 16,
      ),
      leading: Radio<T>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
      ),
    );
  }
}
