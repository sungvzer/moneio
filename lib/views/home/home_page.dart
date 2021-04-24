import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/firestore/firestore_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/helpers/color_parser.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/helpers/auth/auth_helpers.dart';
import 'package:moneio/helpers/screen.dart';
import 'package:moneio/views/home/add_transaction_page.dart';
import 'package:moneio/views/home/settings_page.dart';
import 'package:moneio/views/home/suggestions_page.dart';
import 'package:moneio/widgets/sum_widget.dart' show SumWidget;
import 'package:moneio/widgets/transaction_list.dart';

class HomePage extends StatelessWidget {
  static const String id = "/home";

  @override
  Widget build(BuildContext context) {
    debugPrint("HomePage.build: Adding PreferenceRead...");
    BlocProvider.of<PreferenceBloc>(context)
        .add(PreferenceRead("", defaultSettings));

    debugPrint("HomePage.build: Adding FirestoreRead...");
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
                    "Settings",
                    style: Theme.of(context).textTheme.bodyText2!,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.insert_chart_outlined_rounded),
                  onTap: () {
                    debugPrint("TODO: Stats");
                  },
                  title: Text(
                    "Stats",
                    style: Theme.of(context).textTheme.bodyText2!,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.lightbulb_outline_rounded),
                  onTap: () {
                    debugPrint("TODO: Suggestions");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SuggestionPage(),
                        ));
                  },
                  title: Text(
                    "Suggestions",
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
                        title: Text("Sign out"),
                        content: Text("Are you sure you want to sign out?"),
                        actions: [
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: Text("Sign out"),
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
                    "Sign out",
                    style: Theme.of(context).textTheme.bodyText2!,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
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
              title: "mone.io",
              color: Colors.black,
              child: Text(
                "mone.io",
                style: Theme.of(context).textTheme.headline6!,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SumWidget(settings["human_readable"]),
                SizedBox(
                  height: percentHeight(context) * 4,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "History",
                        style: Theme.of(context).textTheme.headline5!,
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
