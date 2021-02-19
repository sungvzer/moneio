import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/json/json_bloc.dart';
import 'package:moneio/color_palette.dart';
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

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<JsonBloc>(context)
        .add(JsonRead(fileName: "transactions.json"));
    return BlocBuilder<JsonBloc, JsonState>(
      builder: (context, state) {
        // debugPrint(
        //     "State{error: ${state.isError}, hasValue: ${state.hasValue}, message: ${state.message}, value: ${state.hasValue ? state.value : ""}}");
        if (state.isError) {
          debugPrint("Error, returning container.");
          return Container(
            child: Text("Something went REALLY wrong here.\n${state.message}"),
          );
        } else {
          List<Transaction> l = [];
          if (state.hasValue) {
            if (state.value is List) {
              List v = state.value as List;
              if (v.isNotEmpty) {
                for (var x in state.value) {
                  l.add(Transaction.fromJSON(x));
                }
              } else {
                // TODO: Maybe do an EmptyTransactionList so we can add fancy stuff to that?
                return Container();
              }
            } else {
              l.add(Transaction.fromJSON(state.value));
            }
          }
          if (l != null) return _TransactionList(l);
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
