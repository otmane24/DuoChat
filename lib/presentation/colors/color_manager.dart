import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.formHex("#EEC232");
}

extension HexColor on Color {
  static Color formHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString";
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
