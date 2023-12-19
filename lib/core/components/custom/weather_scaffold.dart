import 'package:flutter/material.dart';

import '../../constants/color_constant.dart';
import '../base/base_scaffold.dart';

class WeatherScaffold extends StatelessWidget {
  const WeatherScaffold({required this.child, this.onPop, this.topSafe = false, this.bottomSafe = true, super.key});

  final Widget child;
  final void Function(bool)? onPop;
  final bool topSafe;
  final bool bottomSafe;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: PopScope(
        onPopInvoked: onPop ?? (_) => true,
        child: BaseScaffold(
          backgroundColor: ColorConstant.scaffoldBackgroundColor,
          body: SafeArea(top: false, child: child),
        ),
      ),
    );
  }
}
