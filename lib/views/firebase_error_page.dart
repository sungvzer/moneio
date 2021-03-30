import 'package:flutter/material.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/constants.dart';

class FirebaseErrorPage extends StatefulWidget {
  static const String id = '/error';

  FirebaseErrorPage();

  @override
  FirebaseErrorPageState createState() => FirebaseErrorPageState();
}

class FirebaseErrorPageState extends State<FirebaseErrorPage> {
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
          child: Center(
            child: Text(
              "Something went wrong starting mone.io, try restarting the application.",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: accentColor,
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
