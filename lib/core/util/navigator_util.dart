import 'package:flutter/widgets.dart';

class NavigatorUtil {
  NavigatorUtil._();
  static final navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get safeContext => navigatorKey.currentState!.context;
}
