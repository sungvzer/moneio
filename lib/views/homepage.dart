import 'package:flutter/material.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/widgets/transaction_list.dart';

class HomePage extends StatelessWidget {
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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "History",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.ImperialPrimer,
                ),
              ),
              Divider(
                color: ColorPalette.ImperialPrimer,
                thickness: 1,
              ),
              Expanded(
                child: TransactionListBuilder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
