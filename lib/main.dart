import 'package:flutter/material.dart';
import 'package:moneio/json_reader.dart';
import 'package:moneio/models/transaction.dart';
import 'package:moneio/widgets/translist.dart';
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
          backgroundColor: Color.fromARGB(0, 0, 0, 0),
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
        body: FutureBuilder(
          future: JSONReader.readFromJSON(context),
          initialData: <Transaction>[],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();

              case ConnectionState.done:
                return snapshot.hasData
                    ? TransactionList(snapshot.data)
                    : Text(snapshot.error);
              default:
                return Container(
                  child: Text("Something went REALLY wrong here."),
                );
            }
          },
        ),
      ),
    );
  }
}
