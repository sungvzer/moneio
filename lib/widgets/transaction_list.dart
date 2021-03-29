import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/json/json_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/models/transaction.dart';
import 'package:moneio/screen.dart';

class TransactionListBuilder extends StatefulWidget {
  const TransactionListBuilder();

  _TransactionListBuilderState createState() => _TransactionListBuilderState();
}

class _TransactionListBuilderState extends State<TransactionListBuilder> {
  @override
  void initState() {
    super.initState();
  }

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

    // TODO: Sort based on preferences
    list.sort((a, b) => a.compareTo(b) * -1);
    return list;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<JsonBloc>(context).add(JsonRead("transactions.json"));

    return BlocBuilder<PreferenceBloc, PreferenceState>(
        builder: (context, state) {
      debugPrint(
          "_TransactionListBuilderState.build: got state with type ${state.runtimeType}");
      if (state is PreferenceInitial) {
        return Container();
      }

      var settings;
      if (state is PreferenceWriteState) {
        settings = state.updatedPreferences;
        if (morePrinting)
          debugPrint(
              "_TransactionListBuilderState.build: got write state with settings $settings");
      } else if (state is PreferenceReadState) {
        settings = state.readValue;
        if (settings is! Map<String, dynamic>)
          return CircularProgressIndicator();
        if (morePrinting)
          debugPrint(
              "_TransactionListBuilderState.build: got read state with settings $settings");
      }

      assert(settings is Map<String, dynamic>);
      return BlocBuilder<JsonBloc, JsonState>(
        builder: (context, state) {
          if (morePrinting)
            debugPrint(
                "State{type: ${state.runtimeType}, error: ${state.isError}, hasValue: ${state.hasValue}, message: ${state.message}, value: ${state.hasValue ? state.value : ""}}");
          if (state.isError) {
            String errMsg = "Something went wrong...\n${state.message}";
            return Container(child: Text(errMsg));
          }

          // TODO: Do a file watcher kind of stuff instead of manually checking when building
          // We've written the file and now we update.
          if (state is JsonWriteState)
            BlocProvider.of<JsonBloc>(context)
                .add(JsonRead("transactions.json"));

          if (state.hasValue) {
            List<Transaction> l = readState(state as JsonReadState);
            return _TransactionList(l, settings["human_readable"]);
          }
          return Center(child: CircularProgressIndicator());
        },
      );
    });
  }
}

class _TransactionList extends StatelessWidget {
  final List<Transaction> _elements;
  final bool _humanReadable;

  _TransactionList(this._elements, this._humanReadable);

  @override
  Widget build(BuildContext context) {
    // If our elements list is empty we fall back to an empty screen!
    if (_elements.isEmpty) {
      return Container(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Icon(Icons.money_off),
              Text(
                "No mone, try adding some.",
                style: TextStyle(
                    fontFamily: "Poppins", fontWeight: FontWeight.w500),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      );
    }

    if (morePrinting)
      debugPrint(
          "_TransactionList.build(): device width is ${screenWidth(context).round()}");

    int maxAmountLength = screenWidth(context).round();
    maxAmountLength = (maxAmountLength / 56).floor();
    if (morePrinting)
      debugPrint(
          "_TransactionList.build(): so the new length is $maxAmountLength");

    return ListView.separated(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      separatorBuilder: (context, index) => Divider(
        indent: 25,
        endIndent: 25,
        thickness: 1,
        height: 0,
      ),
      itemBuilder: (context, index) =>
          _TransactionTile(_elements[index], _humanReadable),
      itemCount: _elements.length,
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final Transaction _current;
  final bool _humanReadable;

  _TransactionTile(this._current, this._humanReadable);

  @override
  Widget build(BuildContext context) {
    final DateTime date = _current.date;
    final int amount = _current.amount;

    String amountString = _current.getSeparatedAmountString(
        sign: true, currency: true, humanReadable: _humanReadable);

    if (!_humanReadable) {
      // This is a little hack to make TextOverflow work
      // on a single word string.
      // Example:
      // '+$30,000,000.00' -> '+$30,000[space],000.00'
      if (amountString.length > maxAmountLength) {
        amountString = amountString.substring(0, maxAmountLength) +
            ' ' +
            amountString.substring(maxAmountLength);
      }
    }
    return ListTile(
      // TODO: Transaction deletion and edit
      onLongPress: () => print("TODO: Long press with transaction $_current"),
      leading: Text(
        _current.category.emoji,
      ),
      // This only applies to flutter-dev apparently
      // minLeadingWidth: 3,
      // TODO: Page navigation to a TransactionView(transaction)
      onTap: () => print("TODO: Short press with transaction $_current"),
      title: DefaultTextStyle(
        style: TextStyle(
          fontFamily: "Poppins",
          color: ColorPalette.ImperialPrimer,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                _current.tag,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
            Expanded(
              flex: 0,
              child: Text(date.day.toString().padLeft(2, '0') +
                  '/' +
                  date.month.toString().padLeft(2, '0') +
                  '/' +
                  date.year.toString().padLeft(4, '')),
            ),
            Expanded(
              flex: 2,
              child: Text(
                amountString,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: amount < 0
                      ? ColorPalette.Amour
                      : ColorPalette.PastelGreen,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                ),
                softWrap: false,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
