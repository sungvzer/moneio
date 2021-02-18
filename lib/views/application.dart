import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/json/json_bloc.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/widgets/transaction_list.dart';
import 'package:path_provider/path_provider.dart';

class Application extends StatelessWidget {
  static String _localPath;
  static String _tempPath;
  static String _supportPath;

  static String get localPath => _localPath;
  static String get tempPath => _tempPath;
  static String get supportPath => _supportPath;

  static void loadPaths() {
    getApplicationDocumentsDirectory().then((value) {
      _localPath = value.path;
    });
    getTemporaryDirectory().then((value) {
      _tempPath = value.path;
    });
    getApplicationSupportDirectory().then((value) {
      _supportPath = value.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadPaths();
    // ignore: close_sinks
    JsonBloc b = BlocProvider.of<JsonBloc>(context);

    if (kDebugMode)
      b.add(JsonWrite(
          fileName: "transactions.json",
          value: {
            "id": 5,
            "tag": "Water Bill",
            "icon": "💧",
            "amount": -150.0,
            "currency": "EUR",
            "date": "2020-07-10T22:32",
          },
          append: false));

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
