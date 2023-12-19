import 'package:flutter/material.dart';

class SizeHelper {
  static double lowPadding = 8.0;
  static double defaultPadding = 16.0;
  static double mediumPadding = 24.0;
  static double highPadding = 32.0;

  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  static void init(BuildContext context) {
    final mediaQueryData = MediaQuery.maybeOf(context);
    if (mediaQueryData != null) {
      screenWidth = mediaQueryData.size.width;
      screenHeight = mediaQueryData.size.height;
      blockSizeHorizontal = screenWidth / 100;
      blockSizeVertical = screenHeight / 100;
      _safeAreaHorizontal = mediaQueryData.padding.left + mediaQueryData.padding.right;
      _safeAreaVertical = mediaQueryData.padding.top + mediaQueryData.padding.bottom;
      safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
      safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    }
  }
}
