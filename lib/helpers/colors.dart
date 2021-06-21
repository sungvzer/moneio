import 'package:flutter/material.dart';

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

class ColorPalette {
  static const Color ImperialPrimer = Color(0xFF222F3E);
  static const Color PastelGreen = Color(0xFF5EAB5E);
  static const Color WildCaribbeanGreen = Color(0xFF1DD1A1);
  static const Color DarkMountainMeadow = Color(0xFF10AC84);
  static const Color JungleGreen = Color(0xFF11A681);
  static const Color AquaVelvet = Color(0xFF01A3A4);
  static const Color JadeDust = Color(0xFF00D2D3);
  static const Color Jigglypuff = Color(0xFFFF9FF3);
  static const Color LotusPink = Color(0xFFF368E0);
  static const Color CasandoraYellow = Color(0xFFFECA57);
  static const Color DoubleDragonSkin = Color(0xFFFF9F43);
  static const Color PastelRed = Color(0xFFFF6B6B);
  static const Color Amour = Color(0xFFEE5253);
  static const Color Megaman = Color(0xFF48DBFB);
  static const Color Cyanite = Color(0xFF0ABDE3);
  static const Color JoustBlue = Color(0xFF54A0FF);
  static const Color BleuDeFrance = Color(0xFF2E86DE);
  static const Color NasuPurple = Color(0xFF5F27CD);
  static const Color Bluebell = Color(0xFF341F97);
  static const Color LightBlueBallerina = Color(0xFFC8D6E5);
  static const Color StormPetrel = Color(0xFF8395A7);
  static const Color FuelTown = Color(0xFF576574);
  static const Color White = Color(0xFFFFFFFF);
  static const Color Black = Color(0xFF000000);

  static List<Color> getAllColors(List<Color> toRemove) {
    List<Color> colors = <Color>[
      ImperialPrimer,
      PastelGreen,
      WildCaribbeanGreen,
      DarkMountainMeadow,
      JungleGreen,
      AquaVelvet,
      JadeDust,
      Jigglypuff,
      LotusPink,
      CasandoraYellow,
      DoubleDragonSkin,
      PastelRed,
      Amour,
      Megaman,
      Cyanite,
      JoustBlue,
      BleuDeFrance,
      NasuPurple,
      Bluebell,
      LightBlueBallerina,
      StormPetrel,
      FuelTown,
      White,
      Black
    ];
    for (Color c in toRemove) {
      colors.remove(c);
    }
    return colors;
  }
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
