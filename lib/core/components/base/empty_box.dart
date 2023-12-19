import 'package:flutter/material.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, height: height);
  }
}
