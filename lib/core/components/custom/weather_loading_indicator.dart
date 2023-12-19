import 'package:flutter/material.dart';

class WeatherLoadingIndicator extends StatelessWidget {
  const WeatherLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: CircularProgressIndicator.adaptive(
        strokeWidth: 8,
      ),
    );
  }
}
