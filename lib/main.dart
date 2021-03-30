import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/json/json_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/models/transaction.dart';
import 'package:moneio/views/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<JsonBloc>(
          create: (context) => JsonBloc(),
        ),
        BlocProvider<PreferenceBloc>(
          create: (context) => PreferenceBloc(),
        )
      ],
      child: Application(),
    ),
  );
}

// TODO: Implement dark mode
class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    JsonBloc b = BlocProvider.of<JsonBloc>(context);

    if (morePrinting) debugPrint("Application.build(): Colors are");
    ColorPalette.getAllColors([]).forEach((element) {
      debugPrint(element.toString());
    });

    if (kDebugMode) {
      SharedPreferences.getInstance().then((prefs) => prefs.clear());

      b.add(JsonClear("transactions.json", createFileIfNeeded: true));
    }
    for (var i = 0; i < 10; i++) {
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
          append: true,
          value: newTransaction.toMap(),
          createFileIfNeeded: true));
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
