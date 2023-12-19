import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  const BaseText({
    required this.text,
    required this.fontFamily,
    required this.fontWeight,
    this.size,
    this.color,
    super.key,
  });

  final String text;
  final String fontFamily;
  final FontWeight fontWeight;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}
