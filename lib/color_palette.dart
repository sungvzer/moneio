import 'package:flutter/material.dart';

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
    ];
    for (Color c in toRemove) {
      colors.remove(c);
    }
    return colors;
  }
}
