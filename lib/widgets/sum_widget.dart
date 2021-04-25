import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/firestore/firestore_bloc.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/models/transaction.dart';
import 'package:moneio/helpers/screen.dart';
import 'package:moneio/models/transaction_category.dart';

class SumCarousel extends StatefulWidget {
  final bool humanReadable;
  SumCarousel(this.humanReadable);

  @override
  _SumCarouselState createState() => _SumCarouselState(humanReadable);
}

class _SumCarouselState extends State<SumCarousel> {
  int _currentIndex = 0;
  var _cardList = <Widget Function(List<Transaction>)>[];
  final bool humanReadable;

  _SumCarouselState(this.humanReadable) {
    _cardList = <Widget Function(List<Transaction>)>[
      (l) => _TotalSumCard(this.humanReadable, l),
      (l) => _DaySumCard(this.humanReadable, l),
      (l) => _WeekSumCard(this.humanReadable, l),
      (l) => _MonthSumCard(this.humanReadable, l),
    ];
  }

  void _updateIndex(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];

    for (int i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  void _onPageChanged(int index, CarouselPageChangedReason reason) {
    _updateIndex(index);
  }

  List<Transaction> _getTransactionsFromState(FirestoreState state) {
    List<Transaction> Function(Map<String, dynamic>) getFromDocument =
        (Map<String, dynamic> document) {
      List<Transaction> list = [];
      if (!document.containsKey("transactions")) {
        return list;
      }
      if (document["transactions"] is List) {
        for (var map in document["transactions"]) {
          list.add(Transaction.fromMap(map as Map<String, dynamic>));
        }
      }
      return list;
    };
    List<Transaction> list = [];

    if (state is FirestoreInitial) {
      return list;
    }
    if (state is FirestoreReadState) {
      if (!state.success) return list;
      if (state.type != FirestoreReadType.UserDocument &&
          state.type != FirestoreReadType.UserTransactions) {
        return list;
      }
      if (!state.hasData) return list;
      if (state.type == FirestoreReadType.UserTransactions) return state.data;

      if (state.type == FirestoreReadType.UserDocument)
        return getFromDocument(state.data);
    }
    if (state is FirestoreWriteState) {
      if (!state.success) return list;
      if (!state.hasUpdatedDocument) return list;
      if (!(state.updatedDocument as Map).containsKey("transactions")) {
        return list;
      }

      Map<String, dynamic> document = state.updatedDocument;
      return getFromDocument(document);
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<FirestoreBloc, FirestoreState>(
          builder: (context, state) {
            List<Transaction> list = _getTransactionsFromState(state);
            if (state is FirestoreInitial) return Container();

            return CarouselSlider(
              items: _cardList
                  .map<Widget>((Widget Function(List<Transaction>) fn) {
                return Container(
                  height: percentHeight(context) * 0.33,
                  width: screenWidth(context),
                  child: Card(
                    child: fn(list),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                onPageChanged: _onPageChanged,
                height: percentHeight(context) * 20,
              ),
            );
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: map<Widget>(
            _cardList,
            (index, url) {
              ThemeData theme = Theme.of(context);
              return Container(
                width: percentWidth(context) * 1.5,
                height: percentHeight(context) * 1.5,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.accentColor,
                  ),
                  color: _currentIndex == index
                      ? theme.primaryColor
                      : ColorPalette.LightBlueBallerina,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TotalSumCard extends StatelessWidget {
  final bool humanReadable;
  final List<Transaction> transactions;

  _TotalSumCard(this.humanReadable, this.transactions);

  @override
  Widget build(BuildContext context) {
    return _GenericSumCard(
      title: "Total",
      filter: (Transaction tr) => true,
      humanReadable: this.humanReadable,
      transactions: transactions,
    );
  }
}

class _MonthSumCard extends StatelessWidget {
  final bool humanReadable;
  final List<Transaction> transactions;

  _MonthSumCard(this.humanReadable, this.transactions);

  @override
  Widget build(BuildContext context) {
    return _GenericSumCard(
      title: "This month",
      filter: (Transaction tr) {
        DateTime date = DateTime(tr.date.year, tr.date.month, tr.date.day);
        return date.month == DateTime.now().month;
      },
      humanReadable: this.humanReadable,
      transactions: transactions,
    );
  }
}

class _WeekSumCard extends StatelessWidget {
  final bool humanReadable;
  final List<Transaction> transactions;

  _WeekSumCard(this.humanReadable, this.transactions);

  @override
  Widget build(BuildContext context) {
    return _GenericSumCard(
      title: "This week",
      filter: (Transaction tr) {
        DateTime date = DateTime(tr.date.year, tr.date.month, tr.date.day);
        return date.difference(DateTime.now()).inDays.abs() < 7;
      },
      humanReadable: this.humanReadable,
      transactions: transactions,
    );
  }
}

class _DaySumCard extends StatelessWidget {
  final bool humanReadable;
  final List<Transaction> transactions;

  _DaySumCard(this.humanReadable, this.transactions);

  @override
  Widget build(BuildContext context) {
    return _GenericSumCard(
      title: "Today",
      filter: (Transaction tr) {
        DateTime date = DateTime(tr.date.year, tr.date.month, tr.date.day);
        return date.difference(DateTime.now()).inDays == 0;
      },
      humanReadable: this.humanReadable,
      transactions: transactions,
    );
  }
}

class _GenericSumCard extends StatefulWidget {
  final bool Function(Transaction) filter;
  final String title;
  final bool humanReadable;
  final List<Transaction> transactions;

  _GenericSumCard({
    required this.title,
    required this.filter,
    required this.humanReadable,
    required this.transactions,
  });

  @override
  _GenericSumCardState createState() => _GenericSumCardState();
}

class _GenericSumCardState extends State<_GenericSumCard> {
  List<Transaction> _filterTransactions(List<Transaction> list,
      [bool Function(Transaction)? filter]) {
    if (filter == null) {
      return list;
    }

    var newList = <Transaction>[];
    for (var t in list) {
      if (filter(t)) newList.add(t);
    }
    return newList;
  }

  Transaction _sumTransactions(List<Transaction> list) {
    Map<String, dynamic> sumByCurrency = {};

    for (var t in list) {
      if (sumByCurrency[t.currency] == null) {
        sumByCurrency[t.currency] = t.amount;
        continue;
      }
      sumByCurrency[t.currency] += t.amount;
    }
    String highestCurrency = "";
    int highestAmount = 0;
    for (var entry in sumByCurrency.entries) {
      if (entry.value > highestAmount) {
        highestCurrency = entry.key;
        highestAmount = entry.value;
      }
    }

    return Transaction(
      category: TransactionCategory("NONE"),
      date: DateTime.now(),
      amount: highestAmount,
      currency: highestCurrency,
    );
  }

  _GenericSumCardState();
  @override
  Widget build(BuildContext context) {
    Transaction sum = _sumTransactions(
      _filterTransactions(
        widget.transactions,
      ),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(
          sum.getSeparatedAmountString(
            currency: true,
            humanReadable: widget.humanReadable,
          ),
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: sum.amount < 0
                    ? ColorPalette.Amour
                    : ColorPalette.PastelGreen,
              ),
        ),
      ],
    );
  }
}
