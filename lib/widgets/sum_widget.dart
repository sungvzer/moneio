import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/firestore/firestore_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/models/transaction.dart';
import 'package:moneio/helpers/screen.dart';

class SumWidget extends StatefulWidget {
  final bool _humanReadable;

  SumWidget(this._humanReadable) {
    if (morePrinting) {
      debugPrint("SumWidget: human readable: $_humanReadable");
    }
  }

  @override
  SumWidgetState createState() => SumWidgetState(_humanReadable);
}

class SumWidgetState extends State<SumWidget> {
  int amount = 0;
  String amountString = "";
  bool _humanReadable;
  String _userCurrency = "";

  SumWidgetState(this._humanReadable);

  Widget getInnerWidget(context, state) {
    amount = 0;
    // TODO: Displayed user currency.
    if (state is! FirestoreReadState && state is! FirestoreWriteState)
      return CircularProgressIndicator();
    Map<String, int> sumsByCurrency = {};

    List<Transaction> values = [];
    if (state is FirestoreWriteState && state.hasUpdatedDocument) {
      debugPrint(
          "SumWidgetState.getInnerWidget: write state.. and it has an updated document!");
      var updatedDocument = state.updatedDocument as Map<String, dynamic>;
      assert(updatedDocument["transactions"] != null);
      var maps = updatedDocument["transactions"] as List<dynamic>;
      maps.forEach((element) {
        assert(element is Map);
        values.add(Transaction.fromMap(element));
      });
      debugPrint(
          "SumWidgetState.getInnerWidget: it even has transactions! $values");
    } else if (state is FirestoreReadState &&
        state.type == FirestoreReadType.UserTransactions) {
      assert(state.hasData);
      values = state.data;
    }
    values.forEach((tr) {
      String currency = tr.currency;

      if (!sumsByCurrency.containsKey(currency))
        sumsByCurrency[currency] = tr.amount;
      else {
        sumsByCurrency[currency] = sumsByCurrency[currency]! + tr.amount;
      }
    });

    String maxKey = "";
    int currentSum;

    for (var key in sumsByCurrency.keys) {
      currentSum = sumsByCurrency[key]!;
      // debugPrint("Key: $key, value: $currentSum");
      if (maxKey == "") maxKey = key;
      if (currentSum.abs() >= amount.abs()) {
        amount = currentSum;
        maxKey = key;
      }
    }

    if (morePrinting) {
      debugPrint(
          "SumWidget.getInnerWidget: human readable format is ${_humanReadable ? "on" : "off"}");
    }

    amountString = Transaction(
      amount: amount,
      currency: maxKey == "" ? _userCurrency : maxKey,
      date: DateTime.now(),
      category: categories["NONE"]!,
    ).getSeparatedAmountString(
        currency: true, sign: false, humanReadable: _humanReadable);

    if (morePrinting)
      debugPrint(
          "SumWidget.getInnerWidget: device width is ${screenWidth(context).round()}");

    int maxAmountLength = screenWidth(context).round();
    maxAmountLength = (maxAmountLength / 40).floor();
    if (morePrinting)
      debugPrint(
          "SumWidget.getInnerWidget: so the new length is $maxAmountLength");

    if (amountString.length > maxAmountLength) {
      amountString = amountString.substring(0, maxAmountLength) +
          ' ' +
          amountString.substring(maxAmountLength);
    }
    return Center(
      child: Text(
        "${amount < 0 ? '-' : ''}$amountString",
        style: Theme.of(context).textTheme.headline4!.copyWith(
              color: amount < 0 ? ColorPalette.Amour : ColorPalette.PastelGreen,
            ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  @override
  Widget build(BuildContext _) {
    return Column(
      children: [
        Text(
          "Total",
          style: Theme.of(_).textTheme.headline5!,
        ),
        BlocBuilder<PreferenceBloc, PreferenceState>(
          builder: (context, preferenceState) {
            if (preferenceState is PreferenceWriteState) {
              _humanReadable =
                  preferenceState.updatedPreferences["human_readable"];
              _userCurrency =
                  preferenceState.updatedPreferences["favorite_currency"];
            } else if (preferenceState is PreferenceReadState &&
                preferenceState.readValue is Map) {
              _humanReadable = preferenceState.readValue["human_readable"];
              _userCurrency = preferenceState.readValue["favorite_currency"];
            }
            return BlocBuilder<FirestoreBloc, FirestoreState>(
              builder: (context, state) {
                var innerWidget = getInnerWidget(context, state);

                var outerWidget = GestureDetector(
                  onTap: () => setState(() => debugPrint("It works now!")),
                  child: SizedBox(
                    height: percentHeight(_) * 12,
                    width: percentWidth(_) * 42,
                    child: DecoratedBox(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: innerWidget,
                        ),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: Theme.of(_).textTheme.subtitle2!.color!,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                );
                return outerWidget;
              },
            );
          },
        ),
      ],
    );
  }
}
