import 'package:flutter/material.dart';
import 'package:weather_flutter/core/components/custom/weather_radio_tile.dart';
import 'package:weather_flutter/core/enums/app_languages.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key, required this.onSelected, this.defaultLang = AppLanguages.en});

  final void Function(AppLanguages languages) onSelected;
  final AppLanguages defaultLang;

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  late AppLanguages selectedLang;

  @override
  void initState() {
    super.initState();
    selectedLang = widget.defaultLang;
  }

  void updateLang(AppLanguages lang) {
    setState(() {
      selectedLang = lang;
    });
    widget.onSelected(selectedLang);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WeatherRadioTile<AppLanguages>(
          text: "EN",
          value: AppLanguages.en,
          groupValue: selectedLang,
          onChanged: (p0) {
            updateLang(p0!);
          },
        ),
        WeatherRadioTile<AppLanguages>(
          text: "TR",
          value: AppLanguages.tr,
          groupValue: selectedLang,
          onChanged: (p0) {
            updateLang(p0!);
          },
        ),
      ],
    );
  }
}
