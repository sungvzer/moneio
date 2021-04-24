import 'package:flutter/material.dart';
import 'package:moneio/color_palette.dart';

class LabelledFormField extends StatelessWidget {
  final String _label;
  final FormField child;
  final TextStyle? style;
  late final InputDecoration? decoration;

  LabelledFormField(this._label,
      {required this.child, this.style, InputDecoration? decoration}) {
    if (decoration == null) {
      this.decoration = _defaultDecoration;
    } else {
      this.decoration = decoration;
    }
  }

  static InputDecoration _defaultDecoration = InputDecoration(
    errorMaxLines: 3,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorPalette.ImperialPrimer,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(14.0),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorPalette.ImperialPrimer,
        width: 2,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(14.0),
      ),
    ),
    contentPadding: EdgeInsets.only(top: 1, bottom: 1, left: 20, right: 20),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _label,
          style: Theme.of(context).textTheme.bodyText2!,
        ),
        SizedBox(
          height: 5,
        ),
        child,
      ],
    );
  }
}
