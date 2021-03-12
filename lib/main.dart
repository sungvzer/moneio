import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moneio/bloc/json/json_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/models/transaction.dart';
import 'package:moneio/views/home_page.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(BlocProvider<JsonBloc>(
    create: (context) => JsonBloc(),
    child: Application(),
  ));
}

class Application extends StatelessWidget {
  static String _localPath = "";
  static String _tempPath = "";
  static String _supportPath = "";

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
    if (kDebugMode) b.add(JsonClear("transactions.json"));
    for (var i = 0; i < 30; i++) {
      var keys = categories.toList();
      keys.shuffle();

      Transaction newTransaction = Transaction(
        category: keys[0],
        currency: currencyToSymbol.keys
            .elementAt(Random().nextInt(currencyToSymbol.length)),
        amount: Random().nextInt(20e7.toInt()) - 10e7.toInt(),
        date: DateTime(Random().nextInt(50) + 1970, Random().nextInt(12),
            Random().nextInt(27)),
        tag: String.fromCharCodes(
            List.generate(30, (index) => Random().nextInt(33) + 89)),
      );

      b.add(JsonWrite("transactions.json",
          append: true, value: newTransaction.toMap()));
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "mone.io",
      initialRoute: "/home",
      routes: {
        HomePage.id: (context) => HomePage(),
      },
    );
  }
}
