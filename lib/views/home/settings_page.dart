import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/firestore/firestore_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/helpers/color_parser.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/helpers/auth/auth_helpers.dart';
import 'package:moneio/helpers/screen.dart';
import 'package:moneio/widgets/setting_list_tile.dart';

class SettingsPage extends StatefulWidget {
  static final String id = '/home/settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget _syncSettingsIcon = Icon(Icons.refresh);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    PreferenceBloc preferenceBloc = BlocProvider.of<PreferenceBloc>(context);
    debugPrint("_SettingsPageState.build: Adding PreferenceRead...");

    return BlocBuilder<FirestoreBloc, FirestoreState>(
      builder: (context, state) {
        if (state is FirestoreWriteState &&
            state.success &&
            state.type == FirestoreWriteType.SyncUserSettings) {
          _syncSettingsIcon = Icon(Icons.check);
        }
        preferenceBloc.add(PreferenceRead("", defaultSettings));
        return BlocBuilder<PreferenceBloc, PreferenceState>(
          builder: (context, state) {
            if (state is PreferenceReadState ||
                (state is PreferenceWriteState && state.success)) {
              // TODO: Handle values not existing
              Map<String, dynamic> values;
              if (state is PreferenceReadState) {
                try {
                  values = Map<String, dynamic>.from(state.readValue);
                } catch (e) {
                  debugPrint(
                      "Call an ambulance call an ambulance, but not for me!");
                  return CircularProgressIndicator();
                }
              } else {
                values = (state as PreferenceWriteState).updatedPreferences;
                if (values == {}) throw UnimplementedError();
              }
              debugPrint(
                  "_SettingsPageState.build: preferences: ${values.toString()}");
              debugPrint(
                  "_SettingsPageState.build: human readable is ${values["human_readable"].toString()}");
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: values["accent_color"] != null
                      ? parseColorString(values["accent_color"]!)
                      : parseColorString(defaultSettings["accent_color"]),
                  elevation: 0,
                  leading: Container(),
                  centerTitle: true,
                  title: Title(
                    title: "mone.io",
                    color: ColorPalette.ImperialPrimer,
                    child: Text(
                      "mone.io",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        color: ColorPalette.ImperialPrimer,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                body: DefaultTextStyle(
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: ColorPalette.ImperialPrimer,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                      child: ListView(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          Text("Common"),
                          SizedBox(
                            height: 1.5 * percentHeight(context),
                          ),
                          SettingListTile<bool>(
                            values["human_readable"]
                                ? values["human_readable"]
                                : false,
                            title: "Human readable",
                            subtitle:
                                "Use readable format for amounts greater than 10'000",
                            settingKey: "human_readable",
                          ),
                          SettingListTile<bool>(
                            values["dark_mode"] ? values["dark_mode"] : false,
                            title: "Dark mode",
                            subtitle: "This feature doesn't currently work",
                            settingKey: "dark_mode",
                          ),
                          SettingListTile<String>(
                            values["accent_color"] != null
                                ? values["accent_color"]
                                : "",
                            title: "Accent color",
                            settingKey: "accent_color",
                          ),
                          SettingListTile<List<String>>(
                            // FIXME: This doesn't show the current setting
                            currencyToSymbol.keys.toList(),
                            title: "Favorite currency",
                            settingKey: "favorite_currency",
                            subtitle:
                                "This will be the default currency when you add a mone",
                          ),
                          ListTile(
                            title: Text(
                              "Sync settings to cloud",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                color: ColorPalette.ImperialPrimer,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            onTap: () {
                              debugPrint(
                                  "_SettingsPageState.build: Syncing $values");

                              setState(() {
                                _syncSettingsIcon = CircularProgressIndicator();
                              });
                              var firestoreBloc =
                                  BlocProvider.of<FirestoreBloc>(context);
                              debugPrint(
                                  "_SettingsPageState.build: SYNCING... $values");
                              firestoreBloc.add(FirestoreWrite(
                                type: FirestoreWriteType.SyncUserSettings,
                                data: values,
                                userId: loggedUID!,
                              ));
                            },
                            trailing: _syncSettingsIcon,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
