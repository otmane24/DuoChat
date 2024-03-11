import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.formHex("#EEC232");
  static Color secondary = HexColor.formHex("#282828");
  static Color backgroundColor = HexColor.formHex("#FFFFFF");
  static Color borderColor = HexColor.formHex("#85808F");
  static Color textColor = HexColor.formHex("#2B0D66");
  static Color textFieldTitleColor = HexColor.formHex("#383838");
  static Color textFieldHintColor = HexColor.formHex("#898989");
  static Color black = HexColor.formHex("#000000");
  static Color black2 = HexColor.formHex("#2D2D2D");
  static Color white = HexColor.formHex("#FFFFFF");
  static Color amber = HexColor.formHex("#FFB11A");
  static Color inactiveColor = HexColor.formHex("#D9D9D9");
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
