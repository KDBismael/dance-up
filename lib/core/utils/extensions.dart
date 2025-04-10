import 'package:flutter/material.dart';

extension HexColorExtension on String {
  Color toColor() {
    final hex = replaceAll("#", "");
    return Color(int.parse("0xff$hex"));
  }
}
