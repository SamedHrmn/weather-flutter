import 'package:flutter/material.dart';

enum AppNavbarPages {
  home(Icons.home),
  settings(Icons.settings);

  final IconData iconData;

  const AppNavbarPages(this.iconData);
}
