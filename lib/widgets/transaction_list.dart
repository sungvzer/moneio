import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/json/json_bloc.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/models/transaction.dart';

class TransactionListBuilder extends StatefulWidget {
  const TransactionListBuilder({Key key}) : super(key: key);

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
        if (x is Map) list.add(Transaction.fromMap(x));
      }
    } else if (state.value is Map<String, dynamic>) {
      list.add(Transaction.fromMap(state.value));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<JsonBloc>(context).add(JsonRead("transactions.json"));
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
          BlocProvider.of<JsonBloc>(context).add(JsonRead("transactions.json"));

        if (state.hasValue) {
          List<Transaction> l = readState(state);
          if (l != null)
            return _TransactionList(l);
          else
            return _TransactionList([]);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _TransactionList extends StatelessWidget {
  final List<Transaction> _elements;

  _TransactionList(this._elements);

  @override
  Widget build(BuildContext context) {
    // If our elements list is empty we fall back to an empty screen!
    if (_elements != null && _elements.isEmpty) {
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

    return ListView.separated(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      separatorBuilder: (context, index) => Divider(
        indent: 25,
        endIndent: 25,
        thickness: 1,
        height: 0,
      ),
      itemBuilder: (context, index) => _TransactionTile(_elements[index]),
      itemCount: _elements.length,
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final Transaction _current;
  _TransactionTile(this._current);

  @override
  Widget build(BuildContext context) {
    final DateTime date = _current.date;
    final int amount = _current.amount;

    // TODO: compute MAX_AMOUNT_LENGTH based on device width?!
    const int MAX_AMOUNT_LENGTH = 10;
    String amountString =
        _current.getSeparatedAmountString(sign: true, currency: true);

    // This is a little hack to make TextOverflow work
    // on a single word string.
    // Example:
    // '+$30,000,000.00' -> '+$30,000[space],000.00'
    if (amountString.length > MAX_AMOUNT_LENGTH) {
      amountString = amountString.substring(0, MAX_AMOUNT_LENGTH) +
          ' ' +
          amountString.substring(MAX_AMOUNT_LENGTH);
    }

    return ListTile(
      onLongPress: () => print("TODO: Long press"),
      leading: Text(
        _current.category.emoji,
      ),
      // This only applies to flutter-dev apparently
      // minLeadingWidth: 3,
      onTap: () => print("TODO: Short press"),
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
