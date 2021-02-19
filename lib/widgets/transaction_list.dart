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
        if (x is Map) list.add(Transaction.fromJSON(x));
      }
    } else if (state.value is Map<String, dynamic>) {
      list.add(Transaction.fromJSON(state.value));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<JsonBloc>(context).add(JsonRead("transactions.json"));
    return BlocBuilder<JsonBloc, JsonState>(
      builder: (context, state) {
        if (MORE_PRINTING)
          debugPrint(
              "State{type: ${state.runtimeType}, error: ${state.isError}, hasValue: ${state.hasValue}, message: ${state.message}, value: ${state.hasValue ? state.value : ""}}");
        // TODO: Do a file watcher kind of stuff instead of manually checking when building
        if (state is JsonWriteState && !state.isError)
          BlocProvider.of<JsonBloc>(context).add(JsonRead("transactions.json"));

        if (state.isError) {
          String errMsg = "Something went wrong...\n${state.message}";
          return Container(child: Text(errMsg));
        }
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
    final double amount = _current.amount;
    String amountString =
        _current.getSeparatedAmountString(sign: true, currency: true);

    return ListTile(
      onLongPress: () => print("TODO: Long press"),
      leading: Text(
        _current.icon,
      ),
      // This only applies to flutter-dev apparently
      // minLeadingWidth: 3,
      dense: true,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
