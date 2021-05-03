import 'package:flutter/material.dart';
import 'package:moneio/color_palette.dart';

Color getAmountColor(int amount) {
  return amount < 0 ? ColorPalette.Amour : ColorPalette.PastelGreen;
}
