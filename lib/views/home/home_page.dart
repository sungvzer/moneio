import 'package:animate_icons/animate_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:moneio/bloc/firestore/firestore_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/helpers/constants.dart';
import 'package:moneio/generated/l10n.dart';
import 'package:moneio/helpers/auth/auth_helpers.dart';
import 'package:moneio/helpers/sorting.dart';
import 'package:moneio/views/home/add_transaction_page.dart';
import 'package:moneio/views/settings/settings_page.dart';
import 'package:moneio/views/stats/stats_page.dart';
import 'package:moneio/widgets/sum_carousel.dart';
import 'package:moneio/widgets/transaction_list.dart';

class HomePage extends StatefulWidget {
  static const String id = "/home";

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  SortType transactionSortType = SortType.ByDate;
  SortStrategy transactionSortStrategy = SortStrategy.Descending;
  final AnimateIconController iconController = AnimateIconController();

  @override
  Widget build(BuildContext context) {
    findSystemLocale();
    debugPrint("main: Locale is ${Intl.systemLocale}");
    if (morePrinting) {
      debugPrint("HomePage.build: Adding PreferenceRead...");
    }
    BlocProvider.of<PreferenceBloc>(context)
        .add(PreferenceRead("", defaultSettings));
    if (morePrinting) {
      debugPrint("HomePage.build: Adding FirestoreRead...");
    }
    BlocProvider.of<FirestoreBloc>(context).add(FirestoreRead(
      type: FirestoreReadType.UserTransactions,
      userId: loggedUID!,
    ));
    return BlocBuilder<PreferenceBloc, PreferenceState>(
      builder: (context, state) {
        Map<String, dynamic> settings = {};
        if (morePrinting) {
          debugPrint("HomePage.build(): getting state ${state.runtimeType}");
        }
        if (state is PreferenceReadState) {
          if (state.readValue is Map) {
            settings = state.readValue;
          }
        } else if (state is PreferenceWriteState) {
          settings = state.updatedPreferences;
        }
        if (morePrinting) {
          debugPrint("HomePage.build(): value is a Map! How convenient!");
        }

        settings = {...defaultSettings, ...settings};

        return Scaffold(
          drawer: Drawer(
            elevation: 1,
            child: ListView(
              // TODO: Other actions
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.settings),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SettingsPage(),
                      ),
                    );
                  },
                  title: Text(
                    Localization.of(context).homeDrawerSettings,
                    style: Theme.of(context).textTheme.bodyText2!,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.insert_chart_outlined_rounded),
                  onTap: () {
                    Navigator.pushNamed(context, StatsPage.id);
                  },
                  title: Text(
                    Localization.of(context).homeDrawerStats,
                    style: Theme.of(context).textTheme.bodyText2!,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  onTap: () {
                    showDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(Localization.of(context).homeDrawerSignOut),
                        content: Text(
                            Localization.of(context).homeSignOutPopupPrompt),
                        actions: [
                          TextButton(
                            child: Text(Localization.of(context)
                                .homeSignOutPopupDismiss),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: Text(Localization.of(context)
                                .homeSignOutPopupConfirm),
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    );
                  },
                  title: Text(
                    Localization.of(context).homeDrawerSignOut,
                    style: Theme.of(context).textTheme.bodyText2!,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: Localization.of(context).homeAddATransactionTooltip,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTransactionPage(),
                ),
              );
            },
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            centerTitle: true,
            leading: Builder(builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            backgroundColor: Theme.of(context).primaryColor,
            title: Title(
              title: Localization.of(context).appName,
              color: Colors.black,
              child: Text(
                Localization.of(context).appName,
                style: Theme.of(context).textTheme.headline6!,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SumCarousel(settings["human_readable"]),
                // SizedBox(
                //   height: percentHeight(context) * 4,
                // ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            Localization.of(context).homeHistory,
                            style: Theme.of(context).textTheme.headline5!,
                          ),
                          Row(
                            children: [
                              PopupMenuButton<SortType>(
                                initialValue: transactionSortType,
                                onSelected: (value) {
                                  setState(() {
                                    transactionSortType = value;
                                  });
                                },
                                tooltip: Localization.of(context).homeHistory,
                                itemBuilder: (context) {
                                  final sortTypes = SortType.values;

                                  return sortTypes
                                      .map(
                                        (e) => PopupMenuItem(
                                          value: e,
                                          child: Text(
                                            getSortTypeName(context, e),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                          ),
                                        ),
                                      )
                                      .toList();
                                },
                                child: Icon(Icons.sort),
                              ),
                              AnimateIcons(
                                startIcon: Icons.arrow_downward,
                                endIcon: Icons.arrow_upward,
                                onStartIconPress: () {
                                  setState(() {
                                    if (morePrinting) {
                                      debugPrint("HomePage: start icon");
                                    }
                                    transactionSortStrategy =
                                        SortStrategy.Ascending;
                                  });
                                  return true;
                                },
                                onEndIconPress: () {
                                  setState(() {
                                    if (morePrinting) {
                                      debugPrint("HomePage: end icon");
                                    }
                                    transactionSortStrategy =
                                        SortStrategy.Descending;
                                  });
                                  return true;
                                },
                                startTooltip:
                                    Localization.of(context).homeAscendingSort,
                                endTooltip:
                                    Localization.of(context).homeDescendingSort,
                                startIconColor:
                                    Theme.of(context).iconTheme.color,
                                duration: Duration(milliseconds: 200),
                                endIconColor: Theme.of(context).iconTheme.color,
                                controller: iconController,
                              ),
                              IconButton(
                                icon: Icon(Icons.refresh),
                                tooltip: Localization.of(context).homeRefresh,
                                onPressed: () {
                                  BlocProvider.of<FirestoreBloc>(context).add(
                                    FirestoreWrite(
                                      type: FirestoreWriteType.InvalidateCache,
                                      userId: loggedUID!,
                                      data: null,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Expanded(
                        child: TransactionListBuilder(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
