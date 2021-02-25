import 'package:flutter/material.dart';
import 'package:moneio/views/add_transaction_page.dart';
import 'package:moneio/widgets/transaction_list.dart';

import '../color_palette.dart';

class HomePage extends StatelessWidget {
  static const String id = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPalette.CasandoraYellow,
        foregroundColor: ColorPalette.ImperialPrimer,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTransactionPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: ColorPalette.CasandoraYellow,
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
    );
  }
}
