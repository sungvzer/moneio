import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/firestore/firestore_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/helpers/constants.dart';
import 'package:moneio/generated/l10n.dart';
import 'package:moneio/helpers/auth/auth_helpers.dart';
import 'package:moneio/helpers/colors.dart';
import 'package:moneio/helpers/screen.dart';
import 'package:moneio/helpers/sorting.dart';
import 'package:moneio/models/arguments/transaction_argument.dart';
import 'package:moneio/models/transaction.dart';
import 'package:moneio/views/home/home_page.dart';
import 'package:moneio/views/home/transaction_view.dart';

class TransactionListBuilder extends StatefulWidget {
  const TransactionListBuilder();

  _TransactionListBuilderState createState() => _TransactionListBuilderState();
}

class _TransactionListBuilderState extends State<TransactionListBuilder> {
  List<Transaction> _cachedTransactions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferenceBloc, PreferenceState>(
        builder: (context, state) {
      if (morePrinting) {
        debugPrint(
            "_TransactionListBuilderState.build: got state with type ${state.runtimeType}");
      }
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

      return BlocBuilder<FirestoreBloc, FirestoreState>(
        builder: (context, state) {
          if (morePrinting) debugPrint("State{type: ${state.runtimeType}");

          if (state is FirestoreWriteState) {
            if (state.hasUpdatedDocument) {
              Map<String, dynamic> updatedDocument =
                  state.updatedDocument! as Map<String, dynamic>;
              assert(updatedDocument["transactions"] != null);
              assert(updatedDocument["transactions"] is List);

              var maps = updatedDocument["transactions"] as List;
              var trs = <Transaction>[];

              maps.forEach((element) {
                assert(element is Map);
                trs.add(Transaction.fromMap(element));
              });
              _cachedTransactions = trs;

              return _TransactionList(trs, settings["human_readable"]!);
            }
          } else if (state is FirestoreReadState) {
            if (state.type == FirestoreReadType.UserTransactions) {
              assert(state.hasData);
              _cachedTransactions = state.data;

              return _TransactionList(state.data, settings["human_readable"]!);
            } else if (state.type == FirestoreReadType.UserDocument) {
              assert(state.hasData);
              var maps = state.data["transactions"] as List;
              var trs = <Transaction>[];

              maps.forEach((element) {
                assert(element is Map);
                trs.add(Transaction.fromMap(element));
              });
              _cachedTransactions = trs;

              return _TransactionList(
                  _cachedTransactions, settings["human_readable"]!);
            }
          }
          return _TransactionList(
              _cachedTransactions, settings["human_readable"]!);
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
                Localization.of(context).homeNoTransactionMessageTitle,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: percentHeight(context) * 1,
              ),
              Text(
                Localization.of(context).homeNoTransactionMessageHint,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 13),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
      );
    }
    HomePageState? homePageState =
        context.findAncestorStateOfType<HomePageState>();
    if (homePageState == null) {
      // This should never happen, if so, crash
      assert(false);
      return Container();
    }

    SortStrategy sortStrategy = homePageState.transactionSortStrategy;
    SortType sortType = homePageState.transactionSortType;

    if (morePrinting) {
      debugPrint("TransactionList: sortStrategy: $sortStrategy");
    }

    List<Transaction> transactions = _elements;
    transactions =
        sortTransactions(transactions, strategy: sortStrategy, type: sortType);

    if (morePrinting)
      debugPrint(
          "_TransactionList.build(): device width is ${screenWidth(context).round()}");

    int maxAmountLength = screenWidth(context).round();
    maxAmountLength = (maxAmountLength / 30).floor();
    if (morePrinting)
      debugPrint(
          "_TransactionList.build(): so the new length is $maxAmountLength");

    return ListView.separated(
      physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      separatorBuilder: (context, index) => Divider(
        indent: 25,
        endIndent: 25,
        thickness: 0,
        height: 0,
      ),
      itemBuilder: (context, index) => _TransactionTile(
          transactions[index], _humanReadable, maxAmountLength),
      itemCount: transactions.length,
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final Transaction _current;
  final bool _humanReadable;
  final int _maxAmountLength;

  _TransactionTile(this._current, this._humanReadable, this._maxAmountLength);

  @override
  Widget build(BuildContext context) {
    final DateTime date = _current.date;
    final int amount = _current.amount;

    String amountString = _current.getSeparatedAmountString(
      sign: true,
      currency: true,
      humanReadable: _humanReadable,
      getDecimalsIfZero: false,
    );

    if (!_humanReadable) {
      // This is a little hack to make TextOverflow work
      // on a single word string.
      // Example:
      // '+$30,000,000.00' -> '+$30,000[space],000.00'
      if (amountString.length > _maxAmountLength) {
        amountString = amountString.substring(0, _maxAmountLength) +
            ' ' +
            amountString.substring(_maxAmountLength);
      }
    } else {
      /* HACK: This solves an issue where amounts in
       the thousands (1000.00-9999.99) were not displayed correctly in human readable scenario */
      if (_current.amount >= 100000 && _current.amount <= 999999) {
        if (amountString.length > _maxAmountLength) {
          amountString = amountString.substring(0, _maxAmountLength) +
              ' ' +
              amountString.substring(_maxAmountLength);
        }
      }
    }
    return ListTile(
      onLongPress: () => showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext dialogContext) {
          return SimpleDialog(
            title: Text(
              'Select action',
              style: Theme.of(dialogContext).textTheme.headline5!,
            ),
            children: [
              SimpleDialogOption(
                child: Text(
                  "Edit",
                  style: Theme.of(dialogContext).textTheme.bodyText2!,
                ),
                onPressed: () {
                  NavigatorState nav = Navigator.of(context);
                  nav.pop();
                  Navigator.pushNamed(context, TransactionView.id,
                      arguments: TransactionArgument(_current));
                },
              ),
              SimpleDialogOption(
                onPressed: () {
                  debugPrint(
                      "_TransactionTileState.build: Asked to delete transaction $_current");
                  BlocProvider.of<FirestoreBloc>(context).add(
                    FirestoreWrite(
                      type: FirestoreWriteType.RemoveSingleUserTransaction,
                      userId: loggedUID!,
                      data: _current.id,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Text(
                  "Delete",
                  style: Theme.of(dialogContext).textTheme.bodyText2!,
                ),
              ),
            ],
          );
        },
      ),
      minLeadingWidth: 25,
      leading: Text(
        _current.category.emoji,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          TransactionView.id,
          arguments: TransactionArgument(_current),
        );
      },
      title: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              _current.tag,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: Theme.of(context).textTheme.bodyText2!,
            ),
          ),
          Expanded(
            flex: 0,
            child: Text(
              date.day.toString().padLeft(2, '0') +
                  '/' +
                  date.month.toString().padLeft(2, '0') +
                  '/' +
                  date.year.toString().padLeft(4, ''),
              style: Theme.of(context).textTheme.bodyText2!,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              amountString,
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: getAmountColor(amount, context),
                  ),
              softWrap: false,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

List<Transaction> sortTransactions(
  List<Transaction> transactions, {
  SortStrategy strategy = SortStrategy.Descending,
  SortType type = SortType.ByDate,
}) {
  switch (type) {
    case SortType.ByDate:
      transactions.sort((first, second) => second.date.compareTo(first.date));
      break;
    case SortType.ByTag:
      transactions.sort((first, second) => second.tag.compareTo(first.tag));
      break;
    case SortType.ByAmount:
      transactions
          .sort((first, second) => second.amount.compareTo(first.amount));
      break;
    case SortType.ByCategory:
      transactions
          .sort((first, second) => second.category.compareTo(first.category));
      break;
  }

  if (strategy == SortStrategy.Ascending) {
    return List.from(transactions.reversed);
  }

  return transactions;
}
