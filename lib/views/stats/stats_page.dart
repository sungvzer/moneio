import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/firestore/firestore_bloc.dart';
import 'package:moneio/helpers/colors.dart';
import 'package:moneio/helpers/constants.dart';
import 'package:moneio/helpers/screen.dart';
import 'package:moneio/models/currencies.dart';
import 'package:moneio/models/transaction.dart';
import 'package:moneio/models/transaction_category.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:moneio/generated/l10n.dart';

enum _DisplayType { ByNumber, ByAmount }

class StatsPage extends StatefulWidget {
  static const String id = "/stats";
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with SingleTickerProviderStateMixin {
  List<Transaction> _transactions = [];
  late TabController _controller;

  static List<Tab> _tabs = [
    Tab(
      text: Localization.current.statisticsCategories,
      icon: Icon(Icons.category),
    ),
    Tab(
      text: Localization.current.statisticsCurrencies,
      icon: Icon(Icons.attach_money),
    ),
  ];

  _StatsPageState() {
    _controller =
        TabController(length: _tabs.length, vsync: this, initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {
    Localization local = Localization.of(context);
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          labelColor: Theme.of(context).textTheme.bodyText1!.color,
          indicatorColor: Theme.of(context).textTheme.bodyText1!.color,
          controller: _controller,
          tabs: _tabs,
          dragStartBehavior: DragStartBehavior.down,
        ),
        title: Text(
          local.statisticsTitle,
          style: Theme.of(context).textTheme.headline6!,
        ),
      ),
      body: BlocBuilder<FirestoreBloc, FirestoreState>(
        builder: (context, state) {
          _transactions = _getTransactionsFromState(state);
          debugPrint(
              "_StatsPageBodyState.build: got ${_transactions.length} transactions");
          return TabBarView(
            controller: _controller,
            children: [
              _CategoriesStats(_transactions),
              _CurrenciesStats(_transactions)
            ],
            physics: BouncingScrollPhysics(),
          );
        },
      ),
    );
  }
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

class _CurrenciesStats extends StatefulWidget {
  final List<Transaction> _transactions;
  const _CurrenciesStats(this._transactions);

  @override
  _CurrenciesStatsState createState() => _CurrenciesStatsState(_transactions);
}

class _CurrenciesStatsState extends State<_CurrenciesStats> {
  final List<Transaction> _transactions;
  _DisplayType displayType = _DisplayType.ByNumber;
  _CurrenciesStatsState(this._transactions);

  @override
  Widget build(BuildContext context) {
    Localization local = Localization.of(context);
    const List<Color> lightColors = [
      ColorPalette.Amour,
      ColorPalette.JadeDust,
      ColorPalette.DoubleDragonSkin,
      ColorPalette.PastelGreen,
      ColorPalette.CasandoraYellow,
      ColorPalette.Jigglypuff,
      ColorPalette.Bluebell,
    ];
    final List<Color> darkColors = List.generate(
        lightColors.length, (index) => darken(lightColors[index], 30));
    return Padding(
        padding: EdgeInsets.all(percentWidth(context) * 5),
        child: Column(
          children: [
            Text(
              local.statisticsCountBy,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            DropdownButton<_DisplayType>(
              style: Theme.of(context).textTheme.bodyText2,
              isExpanded: true,
              onChanged: (type) {
                if (type == null) {
                  return;
                }
                setState(() {
                  displayType = type;
                });
                debugPrint(
                    "_CurrenciesStatsState.build: changed to ${type.toString()}");
              },
              items: [
                DropdownMenuItem(
                  child: Text(local.transactionAmount),
                  value: _DisplayType.ByAmount,
                ),
                DropdownMenuItem(
                  child: Text(local.statisticsCountByNumber),
                  value: _DisplayType.ByNumber,
                ),
              ],
              value: displayType,
            ),
            this._transactions.isNotEmpty
                ? PieChart(
                    animationDuration: Duration(seconds: 2),
                    colorList: Theme.of(context).brightness == Brightness.light
                        ? lightColors
                        : darkColors,
                    dataMap: _computeCurrenciesMap(_transactions,
                        groupingThreshold: 4, displayType: displayType),
                    chartType: ChartType.ring,
                    initialAngleInDegree: 270,
                    chartRadius: percentWidth(context) * 50,
                    ringStrokeWidth: percentWidth(context) * 12,
                    legendOptions: LegendOptions(
                      showLegends: true,
                      legendPosition: LegendPosition.top,
                      showLegendsInRow: false,
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValues: false,
                    ),
                  )
                : Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Icon(Icons.money_off),
                          Text(
                            local.homeNoTransactionMessageTitle,
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ),
                  ),
          ],
        ));
  }
}

class _CategoriesStats extends StatefulWidget {
  final List<Transaction> _transactions;
  _CategoriesStats(this._transactions);

  @override
  _CategoriesStatsState createState() => _CategoriesStatsState(_transactions);
}

class _CategoriesStatsState extends State<_CategoriesStats> {
  final List<Transaction> _transactions;
  _DisplayType _displayType = _DisplayType.ByNumber;
  _CategoriesStatsState(this._transactions);

  @override
  Widget build(BuildContext context) {
    const List<Color> lightColors = [
      ColorPalette.Amour,
      ColorPalette.JadeDust,
      ColorPalette.DoubleDragonSkin,
      ColorPalette.PastelGreen,
      ColorPalette.CasandoraYellow,
      ColorPalette.Jigglypuff,
      ColorPalette.Bluebell,
    ];
    final List<Color> darkColors = List.generate(
        lightColors.length, (index) => darken(lightColors[index], 30));
    Localization local = Localization.of(context);
    return Padding(
      padding: EdgeInsets.all(percentWidth(context) * 5),
      child: Column(
        children: [
          Text(
            local.statisticsCountBy,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          DropdownButton<_DisplayType>(
            style: Theme.of(context).textTheme.bodyText2,
            items: [
              DropdownMenuItem(
                child: Text(local.transactionAmount),
                value: _DisplayType.ByAmount,
              ),
              DropdownMenuItem(
                child: Text(local.statisticsCountByNumber),
                value: _DisplayType.ByNumber,
              ),
            ],
            isExpanded: true,
            value: _displayType,
            onChanged: (value) {
              if (value == null) {
                return;
              }
              setState(() {
                _displayType = value;
              });
            },
          ),
          this._transactions.isNotEmpty
              ? PieChart(
                  animationDuration: Duration(seconds: 2),
                  colorList: Theme.of(context).brightness == Brightness.light
                      ? lightColors
                      : darkColors,
                  dataMap: _computeCategoriesMap(_transactions,
                      groupingThreshold: 4, displayType: _displayType),
                  chartType: ChartType.ring,
                  initialAngleInDegree: 270,
                  chartRadius: percentWidth(context) * 50,
                  ringStrokeWidth: percentWidth(context) * 12,
                  legendOptions: LegendOptions(
                    showLegends: true,
                    legendPosition: LegendPosition.top,
                    showLegendsInRow: false,
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValues: false,
                  ),
                )
              : Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Icon(Icons.money_off),
                        Text(
                          local.homeNoTransactionMessageTitle,
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

Map<String, double> _computeCurrenciesMap(
  List<Transaction> transactions, {
  int groupingThreshold = 0,
  _DisplayType displayType = _DisplayType.ByNumber,
}) {
  Map<Currency, double> map = {};
  Map<String, double> percentages = {};
  int transactionCount = transactions.length;

  if (displayType == _DisplayType.ByNumber) {
    for (Transaction t in transactions) {
      if (!map.containsKey(t.currency)) {
        map[t.currency] = 1;
      } else {
        map[t.currency] = map[t.currency]! + 1;
      }
    }
  } else {
    for (Transaction t in transactions) {
      if (!map.containsKey(t.currency)) {
        map[t.currency] = t.amount.toDouble().abs();
      } else {
        map[t.currency] = map[t.currency]! + t.amount.toDouble().abs();
      }
    }
  }

  var entries = map.entries.toList();
  entries.sort((first, second) => first.value.compareTo(second.value));

  double otherCurrenciesSum = 0;
  if (entries.length >= groupingThreshold) {
    for (int group = 0; group < entries.length - groupingThreshold; group++) {
      otherCurrenciesSum += entries[group].value;
      map.remove(entries[group].key);
    }
  }
  int total;
  if (displayType == _DisplayType.ByNumber) {
    total = transactionCount;
  } else {
    total = transactions.fold(
        0, (previous, element) => previous + element.amount.abs());
  }

  for (int index = 0; index < map.entries.length; index++) {
    final entry = map.entries.elementAt(index);
    double percentage = (entry.value / total * 100).roundToDouble();
    debugPrint(
        "_computeCurrenciesMap: index $index, element ${map.entries.elementAt(index).toString()}");
    percentages[currencyCode(entry.key) + ' - $percentage%'] = percentage;
  }

  if (entries.length >= groupingThreshold) {
    double otherPercentage = (otherCurrenciesSum / total * 100).roundToDouble();
    percentages["Other currencies - $otherPercentage%"] = otherPercentage;
  }
  debugPrint("_computeCurrenciesMap: percentages $percentages");
  return percentages;
}

Map<String, double> _computeCategoriesMap(
  List<Transaction> transactions, {
  int groupingThreshold = 0,
  _DisplayType displayType = _DisplayType.ByNumber,
}) {
  Map<String, double> map = {};
  Map<String, int> counts = {};
  int transactionCount = transactions.length;

  // TODO: Maybe this is a naive way of computing percentages
  // Like, what about 10000 JPY (€75 as of 2021-06-09) vs €100?
  // Should they be converted to a common value and then sorted?
  int amountSum = 0;

  if (displayType == _DisplayType.ByNumber) {
    for (Transaction t in transactions) {
      if (!counts.containsKey(t.category.key)) {
        counts[t.category.key] = 1;
      } else {
        counts[t.category.key] = counts[t.category.key]! + 1;
      }
    }
  } else {
    for (Transaction t in transactions) {
      amountSum += t.amount.abs();
      if (!counts.containsKey(t.category.key)) {
        counts[t.category.key] = t.amount.abs();
      } else {
        counts[t.category.key] = counts[t.category.key]! + t.amount.abs();
      }
    }
  }

  var entries = counts.entries.toList();
  entries.sort((first, second) => first.value.compareTo(second.value));

  for (int group = 0; group < entries.length - groupingThreshold; group++) {
    if (!counts.containsKey("OTHER"))
      counts["OTHER"] = entries[group].value;
    else
      counts["OTHER"] = counts["OTHER"]! + entries[group].value;
    counts.remove(entries[group].key);
  }

  entries = counts.entries.toList();
  entries.sort((first, second) => second.value.compareTo(first.value));

  for (var entry in entries) {
    int total;
    if (displayType == _DisplayType.ByNumber) {
      total = transactionCount;
    } else {
      total = amountSum;
    }
    double percentage = (entry.value / total * 100).roundToDouble();
    String keyForMap = "";
    if (entry.key == "OTHER") {
      keyForMap = "Other categories";
    } else {
      final TransactionCategory category = Constants.getCategory(entry.key);
      keyForMap = category.name;
    }

    keyForMap += " - $percentage%";
    map[keyForMap] = entry.value.toDouble();
  }
  return map;
}
