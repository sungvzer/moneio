import 'package:flutter/material.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _elements;

  TransactionList(this._elements);

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
      itemBuilder: (context, index) => TransactionTile(_elements[index]),
      itemCount: _elements.length,
    );
  }
}

class TransactionTile extends StatelessWidget {
  final Transaction current;
  TransactionTile(this.current);

  @override
  Widget build(BuildContext context) {
    final DateTime date = current.date;
    final double amount = current.amount;
    String amountString = current.getSeparatedAmountString();
    amountString =
        (amount < 0 ? '-' : '+') + current.getCurrencySymbol() + amountString;

    return ListTile(
      onLongPress: () => print("TODO: Long press"),
      leading: Text(
        current.icon,
      ),
      minLeadingWidth: 7,
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
                current.tag,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(date.day.toString().padLeft(2, '0') +
                  '/' +
                  date.month.toString().padLeft(2, '0') +
                  '/' +
                  date.year.toString().padLeft(4, '')),
            ),
            Expanded(
              flex: 3,
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
