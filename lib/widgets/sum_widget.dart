import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/json/json_bloc.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/models/transaction.dart';
import 'package:moneio/screen.dart';

class SumWidget extends StatefulWidget {
  SumWidget();

  @override
  SumWidgetState createState() => SumWidgetState();
}

class SumWidgetState extends State<SumWidget> {
  // TODO: Remove this?!
  int amount = 0;
  String amountString = "";

  BoxDecoration _decoration = BoxDecoration(
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.all(Radius.circular(20)),
    color: Colors.white,
    border: Border.all(
      color: ColorPalette.ImperialPrimer,
      width: 4,
    ),
  );

  List<Transaction> readState(JsonReadState state) {
    List<Transaction> list = [];
    if (!state.hasValue) return list;

    if (state.value is List) {
      List v = state.value as List;
      if (v.isEmpty) return [];
      for (var x in state.value) {
        if (x is Map<String, dynamic>) list.add(Transaction.fromMap(x));
      }
    } else if (state.value is Map<String, dynamic>) {
      list.add(Transaction.fromMap(state.value));
    }
    return list;
  }

  Widget getInnerWidget(context, state) {
    // TODO: Displayed user currency.
    if (state is! JsonReadState) return CircularProgressIndicator();
    Map<String, int> sumsByCurrency = {};
    {
      final List<Transaction> values = readState(state);
      values.forEach((tr) {
        String currency = tr.currency;

        if (!sumsByCurrency.containsKey(currency))
          sumsByCurrency[currency] = tr.amount;
        else {
          // TODO: Null safety
          sumsByCurrency[currency] = sumsByCurrency[currency]! + tr.amount;
        }
      });
    }

    String maxKey = "";
    int currentSum;

    // FIXME: SUM IS BROKEN
    for (var key in sumsByCurrency.keys) {
      currentSum = sumsByCurrency[key]!;
      debugPrint("Key: $key, value: $currentSum");
      if (maxKey == "") maxKey = key;
      if (currentSum.abs() >= amount.abs()) {
        amount = currentSum;
        maxKey = key;
      }
    }

    debugPrint("maxKey: $maxKey, maxSum: $amount");

    // TODO: User preference for humanReadable
    amountString = Transaction(amount: amount, currency: maxKey)
        .getSeparatedAmountString(
            currency: true, sign: false, humanReadable: true);

    // Trick to split at my desired length.
    const int MAX_AMOUNT_LENGTH = 10;
    if (amountString.length > MAX_AMOUNT_LENGTH) {
      amountString = amountString.substring(0, MAX_AMOUNT_LENGTH) +
          ' ' +
          amountString.substring(MAX_AMOUNT_LENGTH);
    }
    return Center(
      child: Text(
        "${amount < 0 ? '-' : ''}$amountString",
        style: TextStyle(
          color: amount < 0 ? ColorPalette.Amour : ColorPalette.PastelGreen,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
          fontSize: 30,
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
          style: TextStyle(
              color: ColorPalette.ImperialPrimer,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              fontSize: 20),
        ),
        BlocBuilder<JsonBloc, JsonState>(
          builder: (context, state) {
            var innerWidget = getInnerWidget(context, state);

            var outerWidget = GestureDetector(
              onTap: () => setState(() => debugPrint("It works now!")),
              child: SizedBox(
                height: percentHeight(_) * 15,
                width: percentWidth(_) * 50,
                child: DecoratedBox(
                  child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: innerWidget,
                      )),
                  decoration: _decoration,
                ),
              ),
            );
            return outerWidget;
          },
        ),
      ],
    );
  }
}
