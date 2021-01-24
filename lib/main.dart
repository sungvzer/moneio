import 'package:flutter/material.dart';
import 'package:moneio/widgets/transaction_list.dart';
import 'color_palette.dart';

void main() {
  runApp(Application());
}

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "mone.io",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Title(
            title: "mone.io",
            color: Colors.black,
            child: Center(
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
        ),
        body: TransactionListBuilder(),
      ),
    );
  }
}
