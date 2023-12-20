import 'package:flutter/material.dart';
import 'package:weather_flutter/core/util/size_helper.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
      child: SizedBox(
        width: SizeHelper.blockSizeHorizontal * 30,
        child: child,
      ),
    );
  }
}
