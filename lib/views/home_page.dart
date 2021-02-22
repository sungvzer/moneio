import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/json/json_bloc.dart';
import 'package:moneio/widgets/transaction_list.dart';

import '../color_palette.dart';

class HomePage extends StatelessWidget {
  static const String id = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // ignore: close_sinks
          JsonBloc b = BlocProvider.of<JsonBloc>(context);
          b.add(JsonWrite(
            "transactions.json",
            value: {
              "id": 5,
              "tag": "Water Bill",
              "icon": "💧",
              "amount": -150.0,
              "currency": "EUR",
              "date": "2020-07-10T22:32",
            },
            append: true,
          ));
          b.add(JsonRead("transactions.json"));
        },
        child: Icon(Icons.add),
      ),
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
    );
  }
}