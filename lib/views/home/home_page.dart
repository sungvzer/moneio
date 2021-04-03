import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/json/json_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/color_parser.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/views/home/add_transaction_page.dart';
import 'package:moneio/views/home/settings_page.dart';
import 'package:moneio/views/home/suggestions_page.dart';
import 'package:moneio/widgets/sum_widget.dart' show SumWidget;
import 'package:moneio/widgets/transaction_list.dart';

import 'package:moneio/color_palette.dart';

class HomePage extends StatelessWidget {
  static const String id = "/home";

  @override
  Widget build(BuildContext context) {
    debugPrint("HomePage.build: Adding PreferenceRead...");
    BlocProvider.of<PreferenceBloc>(context)
        .add(PreferenceRead("", defaultSettings));

    debugPrint("HomePage.build: Adding JsonRead...");
    BlocProvider.of<JsonBloc>(context).add(JsonRead("transactions.json"));
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
          debugPrint("HomePage.build(): checking if it matches default...");
        }

        List<String> nonMatchingKeys = [];
        for (MapEntry defaultEntry in defaultSettings.entries) {
          bool matched = false;
          for (MapEntry valueEntry in settings.entries) {
            if (defaultEntry.key == valueEntry.key) matched = true;
          }
          if (!matched) {
            nonMatchingKeys.add(defaultEntry.key as String);
          }
        }

        if (nonMatchingKeys.isNotEmpty) {
          if (morePrinting) {
            debugPrint(
                "HomePage.build(): Shenanigans! It does not match default!");
            debugPrint(
                "HomePage.build(): Non matching keys are $nonMatchingKeys");
            debugPrint("HomePage.build(): Let me set it back to normal");
          }
          for (var key in nonMatchingKeys) {
            settings[key] = defaultSettings[key];
          }
        } else {
          if (morePrinting) {
            debugPrint("HomePage.build(): It does! Settings are: $settings");
          }
        }

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
                        ));
                  },
                  title: Text("Settings"),
                ),
                ListTile(
                  leading: Icon(Icons.insert_chart_outlined_rounded),
                  onTap: () {
                    debugPrint("TODO: Stats");
                  },
                  title: Text("Stats"),
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
                  title: Text("Suggestions"),
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                  title: Text("Logout"),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: settings["accent_color"] != null
                ? parseColorString(settings["accent_color"])
                : parseColorString(defaultSettings["accent_color"]),
            foregroundColor: ColorPalette.ImperialPrimer,
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
                  color: ColorPalette.ImperialPrimer,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            backgroundColor: settings["accent_color"] != null
                ? parseColorString(settings["accent_color"])
                : parseColorString(defaultSettings["accent_color"]),
            title: Title(
              title: "mone.io",
              color: Colors.black,
              child: Text(
                "mone.io",
                style: TextStyle(
                  fontSize: 26,
                  color: ColorPalette.ImperialPrimer,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SumWidget(settings["human_readable"]),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 100 * 4,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "History",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.ImperialPrimer,
                        ),
                      ),
                      Divider(
                        color: ColorPalette.ImperialPrimer,
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
