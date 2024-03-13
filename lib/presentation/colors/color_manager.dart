import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.formHex("#32A3FF");
  static Color white = HexColor.formHex("#FFFFFF");
  static Color black = HexColor.formHex("#282828");
  static Color grey = HexColor.formHex("#585858");
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
