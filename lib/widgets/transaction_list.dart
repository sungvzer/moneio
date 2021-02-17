import 'package:flutter/material.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/json_reader.dart';
import 'package:moneio/models/transaction.dart';

class TransactionListBuilder extends StatelessWidget {
  const TransactionListBuilder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: JSONReader.readTransactionsFromJSON(),
      initialData: <Transaction>[],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());

          case ConnectionState.done:
            return snapshot.hasData
                ? _TransactionList(snapshot.data)
                : Text(snapshot.error);
          default:
            return Container(
              child: Text("Something went REALLY wrong here."),
            );
        }
      },
    );
  }
}

class _TransactionList extends StatelessWidget {
  final List<Transaction> _elements;

  _TransactionList(this._elements);

  @override
  Widget build(BuildContext context) {
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
    String amountString = _current.getSeparatedAmountString(sign: true);

    return ListTile(
      onLongPress: () => print("TODO: Long press"),
      leading: Text(
        _current.icon,
      ),
      minLeadingWidth: 3,
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
