import 'package:flutter/material.dart';
import 'package:moneio/color_palette.dart';

Color getAmountColor(int amount, BuildContext context) {
  if (amount == 0) return Theme.of(context).textTheme.bodyText2!.color!;
  return amount < 0 ? ColorPalette.Amour : ColorPalette.PastelGreen;
}
