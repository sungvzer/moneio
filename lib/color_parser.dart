import 'package:flutter/material.dart';

Color parseColorString(String str) {
  assert(isColorString(str), "Not a color string: $str");

  str = str.substring(2);
  return Color(int.parse(str, radix: 16));
}

String colorToString(Color c) {
  String result = "0x";
  result += c.alpha.toRadixString(16).padLeft(2, '0');
  result += c.red.toRadixString(16).padLeft(2, '0');
  result += c.green.toRadixString(16).padLeft(2, '0');
  result += c.blue.toRadixString(16).padLeft(2, '0');
  return result;
}

bool isColorString(String str) {
  // 0xAARRGGBB
  return str.length == 10 &&
      str.startsWith('0x') &&
      str.substring(2).contains(RegExp(r'^([a-fA-F0-9]{8}|[a-fA-F0-9]{4})$'));
}
