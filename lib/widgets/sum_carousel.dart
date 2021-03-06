import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/firestore/firestore_bloc.dart';
import 'package:moneio/helpers/colors.dart';
import 'package:moneio/helpers/constants.dart';
import 'package:moneio/generated/l10n.dart';
import 'package:moneio/helpers/screen.dart';
import 'package:moneio/models/currencies.dart';
import 'package:moneio/models/transaction.dart';

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
                enableInfiniteScroll: false,
                scrollPhysics: BouncingScrollPhysics(),
                onPageChanged: _onPageChanged,
                height: percentHeight(context) * 20,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
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
      title: Localization.of(context).homeTotal,
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
      title: Localization.of(context).homeThisMonth,
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
      title: Localization.of(context).homeThisWeek,
      filter: (Transaction tr) {
        DateTime date = DateTime(tr.date.year, tr.date.month, tr.date.day);
        DateTime today = DateTime.now();

        /**
         * The difference from today can only be less than 0,
         * given that we don't allow for transactions from the future.
         * For example: if today's weekday is Thursday (= 4 in today.weekday)
         * we only allow transactions that have occurred
         * between 0 (today) and 3 days before (Wednesday, Tuesday and Monday).
         **/
        return date.difference(today).inDays.abs() < today.weekday;
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
      title: Localization.of(context).homeToday,
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
  List<Transaction> _filterTransactions(
    List<Transaction> list,
    bool Function(Transaction) filter,
  ) {
    // Copy because otherwise list gets modified and that's a no-no
    var newList = List<Transaction>.from(list);
    newList.retainWhere(filter);
    if (morePrinting) {
      debugPrint(
          "_GenericSumCardState._filterTransactions: newList is $newList");
    }
    return newList;
  }

  Transaction _sumTransactions(List<Transaction> list) {
    Map<Currency, dynamic> sumByCurrency = {};

    for (var t in list) {
      if (sumByCurrency[t.currency] == null) {
        sumByCurrency[t.currency] = t.amount;
        continue;
      }
      sumByCurrency[t.currency] += t.amount;
    }
    Currency highestCurrency = Currency.NONE;

    num highestAmount = double.negativeInfinity;
    for (var entry in sumByCurrency.entries) {
      if (entry.value > highestAmount) {
        highestCurrency = entry.key;
        highestAmount = entry.value;
      }
    }

    if (highestAmount == double.negativeInfinity) {
      highestAmount = 0;
    }

    return Transaction(
      category: Constants.getCategory("NONE"),
      date: DateTime.now(),
      amount: highestAmount.toInt(),
      currency: highestCurrency,
    );
  }

  _GenericSumCardState();
  @override
  Widget build(BuildContext context) {
    Transaction sum = _sumTransactions(
      _filterTransactions(
        widget.transactions,
        widget.filter,
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
            sign: true,
          ),
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: getAmountColor(sum.amount, context),
              ),
        ),
      ],
    );
  }
}
