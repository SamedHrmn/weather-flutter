import 'package:flutter/material.dart';
import 'package:weather_flutter/core/components/custom/weather_radio_tile.dart';
import 'package:weather_flutter/core/enums/temperature_unit.dart';

class TempUnitSelector extends StatefulWidget {
  const TempUnitSelector({super.key, required this.onSelected, this.defaultUnit = TemperatureUnit.c});

  final void Function(TemperatureUnit unit) onSelected;
  final TemperatureUnit defaultUnit;

  @override
  State<TempUnitSelector> createState() => _TempUnitSelectorState();
}

class _TempUnitSelectorState extends State<TempUnitSelector> {
  late TemperatureUnit selectedUnit;

  @override
  void initState() {
    super.initState();
    selectedUnit = widget.defaultUnit;
  }

  void updateTempUnit(TemperatureUnit unit) {
    setState(() {
      selectedUnit = unit;
    });
    widget.onSelected(selectedUnit);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeatherRadioTile<TemperatureUnit>(
          text: "C",
          value: TemperatureUnit.c,
          groupValue: selectedUnit,
          onChanged: (p0) {
            updateTempUnit(p0!);
          },
        ),
        WeatherRadioTile<TemperatureUnit>(
          text: "F",
          value: TemperatureUnit.f,
          groupValue: selectedUnit,
          onChanged: (p0) {
            updateTempUnit(p0!);
          },
        ),
      ],
    );
  }
}
