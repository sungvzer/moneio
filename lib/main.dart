import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moneio/bloc/json/json_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/constants.dart';
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
    if (kDebugMode)
      b.add(JsonWrite("transactions.json",
          value: {
            "amount": 320,
            "date": DateTime(2020, 05, 02, 10, 10).toIso8601String(),
            "icon": "🍕",
            "tag": "Pizzamandolino",
            "category": categories
                .firstWhere((category) => category.uniqueID == "FOOD"),
            "currency": "EUR"
          },
          append: false,
          createFileIfNeeded: true));

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
