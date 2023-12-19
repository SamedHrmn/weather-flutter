import 'package:flutter/material.dart';

class BaseIconButton extends StatelessWidget {
  const BaseIconButton({super.key, required this.iconData, required this.onPressed, this.iconColor, this.shadows, this.iconSize});

  final IconData iconData;
  final void Function() onPressed;
  final Color? iconColor;
  final List<Shadow>? shadows;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        iconData,
        size: iconSize,
        color: iconColor,
        shadows: shadows,
      ),
    );
  }
}
