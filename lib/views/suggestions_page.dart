import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moneio/color_palette.dart';

class SuggestionPage extends StatefulWidget {
  SuggestionPage();

  @override
  SuggestionPageState createState() => SuggestionPageState();
}

class SuggestionPageState extends State<SuggestionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
        style: TextStyle(
          fontFamily: "Poppins",
          color: ColorPalette.ImperialPrimer,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Text("TODO: This needs to be implemented."),
            // TODO: Implement suggestions
            physics: BouncingScrollPhysics(),
            clipBehavior: Clip.none,
          ),
        ),
      ),
      appBar: AppBar(
        // TODO: Settings BlocBuilder
        backgroundColor: ColorPalette.PastelRed,
        elevation: 0,
        leading: Container(),
        centerTitle: true,
        title: Title(
          title: "mone.io",
          color: ColorPalette.ImperialPrimer,
          child: Text(
            "mone.io",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              color: ColorPalette.ImperialPrimer,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
