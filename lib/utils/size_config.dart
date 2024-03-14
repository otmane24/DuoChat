import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? blockSizeHorizontal;
  static double? screenHeight;
  static double? blockSizeVertical;

  // Define a method to initialize the SizeConfig
  void init(BuildContext context) {
    // Get the media query data from the context
    _mediaQueryData = MediaQuery.of(context);
    // Set the screen width to the width from the media query data
    screenWidth = _mediaQueryData!.size.width;
    // Set the screen height to the height from the media query data
    screenHeight = _mediaQueryData!.size.height;
    // Set the horizontal block size to the screen width divided by 100
    blockSizeHorizontal = screenWidth! / 100;
    // Set the vertical block size to the screen height divided by 100
    blockSizeVertical = screenHeight! / 100;
  }
}
