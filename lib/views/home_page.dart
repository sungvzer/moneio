import 'package:flutter/material.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/views/add_transaction_page.dart';
import 'package:moneio/widgets/transaction_list.dart';

import '../color_palette.dart';

class HomePage extends StatelessWidget {
  static const String id = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 1,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentColor,
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
        centerTitle: true,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.menu,
              color: ColorPalette.ImperialPrimer,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
        backgroundColor: accentColor,
        title: Title(
          title: "mone.io",
          color: Colors.black,
          child: Text(
            "mone.io",
            style: TextStyle(
              fontSize: 26,
              color: ColorPalette.ImperialPrimer,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
          ],
        ),
      ),
    );
  }
}
