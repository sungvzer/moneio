import 'package:flutter/material.dart';
import 'package:moneio/color_palette.dart';

/// Make a color more transparent by [percent] amount (100 = full transparency)
Color fade(Color c, [int percent = 10]) {
  var factor = 1 - percent / 100;
  return Color.fromARGB(
      (c.alpha * factor).clamp(0, 1).round(), c.red, c.green, c.blue);
}

/// Make a color more opaque by [percent] amount (100 = full opacity)
Color opacify(Color c, [int percent = 10]) {
  var factor = 1 - percent / 100;
  return Color.fromARGB(
      (c.alpha + c.alpha * factor).clamp(0, 1).round(), c.red, c.green, c.blue);
}

/// https://stackoverflow.com/a/60191441/7163750
///
/// Darken a color by [percent] amount (100 = black)
Color darken(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var f = 1 - percent / 100;
  return Color.fromARGB(c.alpha, (c.red * f).round(), (c.green * f).round(),
      (c.blue * f).round());
}

/// https://stackoverflow.com/a/60191441/7163750
///
/// Lighten a color by [percent] amount (100 = white)
Color lighten(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var p = percent / 100;
  return Color.fromARGB(
      c.alpha,
      c.red + ((255 - c.red) * p).round(),
      c.green + ((255 - c.green) * p).round(),
      c.blue + ((255 - c.blue) * p).round());
}

Color getAmountColor(int amount, BuildContext context) {
  if (amount == 0) return Theme.of(context).textTheme.bodyText2!.color!;
  return amount < 0 ? ColorPalette.Amour : ColorPalette.PastelGreen;
}

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
