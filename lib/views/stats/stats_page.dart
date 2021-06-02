import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/firestore/firestore_bloc.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/helpers/colors.dart';
import 'package:moneio/helpers/screen.dart';
import 'package:moneio/models/transaction.dart';
import 'package:moneio/models/transaction_category.dart';
import 'package:pie_chart/pie_chart.dart';

class StatsPage extends StatefulWidget {
  static const String id = "/stats";
  @override
  _StatsPageState createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage>
    with SingleTickerProviderStateMixin {
  List<Transaction> _transactions = [];
  late TabController _controller;

  static const List<Tab> _tabs = [
    Tab(
      text: "Categories",
      icon: Icon(Icons.category),
    ),
    Tab(
      text: "Currencies",
      icon: Icon(Icons.attach_money),
    ),
  ];

  _StatsPageState() {
    _controller =
        TabController(length: _tabs.length, vsync: this, initialIndex: 0);
  }
  @override
  Widget build(BuildContext context) {
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
          "Statistics",
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

class _CurrenciesStats extends StatelessWidget {
  final List<Transaction> _transactions;
  const _CurrenciesStats(this._transactions);

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
    return Padding(
      padding: EdgeInsets.all(percentWidth(context) * 5),
      child: PieChart(
        animationDuration: Duration(seconds: 2),
        colorList: Theme.of(context).brightness == Brightness.light
            ? lightColors
            : darkColors,
        dataMap: _computeCurrenciesMap(_transactions, groupingThreshold: 4),
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
      ),
    );
  }
}

class _CategoriesStats extends StatelessWidget {
  final List<Transaction> _transactions;
  _CategoriesStats(this._transactions);

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

    return Padding(
      padding: EdgeInsets.all(percentWidth(context) * 5),
      child: PieChart(
        animationDuration: Duration(seconds: 2),
        colorList: Theme.of(context).brightness == Brightness.light
            ? lightColors
            : darkColors,
        dataMap: _computeCategoriesMap(_transactions, groupingThreshold: 4),
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
      ),
    );
  }
}

Map<String, double> _computeCurrenciesMap(List<Transaction> transactions,
    {int groupingThreshold = 0}) {
  Map<String, double> map = {};
  int transactionCount = transactions.length;

  for (Transaction t in transactions) {
    if (!map.containsKey(t.currency)) {
      map[t.currency] = 1;
    } else {
      map[t.currency] = map[t.currency]! + 1;
    }
  }

  var entries = map.entries.toList();
  entries.sort((first, second) => first.value.compareTo(second.value));

  for (int group = 0; group < entries.length - groupingThreshold; group++) {
    if (!map.containsKey("Other currencies"))
      map["Other currencies"] = entries[group].value;
    else
      map["Other currencies"] = map["Other currencies"]! + entries[group].value;
    map.remove(entries[group].key);
  }
  return map;
}

Map<String, double> _computeCategoriesMap(List<Transaction> transactions,
    {int groupingThreshold = 0}) {
  Map<String, double> map = {};
  Map<String, int> counts = {};
  int transactionCount = transactions.length;

  for (Transaction t in transactions) {
    if (!counts.containsKey(t.category.uniqueID)) {
      counts[t.category.uniqueID] = 1;
    } else {
      counts[t.category.uniqueID] = counts[t.category.uniqueID]! + 1;
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
    int percentage = (entry.value / transactionCount * 100).toInt();
    String keyForMap = "";
    if (entry.key == "OTHER") {
      keyForMap = "Other categories";
    } else {
      final TransactionCategory category = categories[entry.key]!;
      keyForMap = category.name;
    }

    keyForMap += " - $percentage%";
    map[keyForMap] = entry.value.toDouble();
  }
  return map;
}
