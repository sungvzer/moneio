import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/firestore/firestore_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/helpers/constants.dart';
import 'package:moneio/helpers/auth/auth_helpers.dart';
import 'package:moneio/helpers/screen.dart';
import 'package:moneio/models/currencies.dart';
import 'package:moneio/widgets/setting_list_tile.dart';
import 'package:moneio/generated/l10n.dart';

class SettingsPage extends StatefulWidget {
  static final String id = '/settings';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Widget _syncSettingsIcon = Icon(Icons.refresh);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    PreferenceBloc preferenceBloc = BlocProvider.of<PreferenceBloc>(context);

    if (morePrinting) {
      debugPrint("_SettingsPageState.build: Adding PreferenceRead...");
    }

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
                  if (morePrinting) {
                    debugPrint(
                        "Call an ambulance call an ambulance, but not for me!");
                  }
                  return CircularProgressIndicator();
                }
              } else {
                values = (state as PreferenceWriteState).updatedPreferences;
                if (values == {}) throw UnimplementedError();
              }
              if (morePrinting) {
                debugPrint(
                    "_SettingsPageState.build: preferences: ${values.toString()}");
              }
              if (morePrinting) {
                debugPrint(
                    "_SettingsPageState.build: human readable is ${values["human_readable"].toString()}");
              }

              List<String> currencyCodeList = currencyCodes();
              currencyCodeList.removeWhere(
                  (element) => element == values["favorite_currency"]);
              currencyCodeList.insert(0, values["favorite_currency"]);
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  centerTitle: true,
                  title: Title(
                    title: Localization.of(context).appName,
                    color: ColorPalette.ImperialPrimer,
                    child: Text(
                      Localization.of(context).appName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                body: Container(
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
                          title: Localization.of(context)
                              .settingsHumanReadableTitle,
                          subtitle: Localization.of(context)
                              .settingsHumanReadableDescription,
                          settingKey: "human_readable",
                        ),
                        SettingListTile<bool>(
                          values["dark_mode"] ? values["dark_mode"] : false,
                          title:
                              Localization.of(context).settingsDarkThemeTitle,
                          subtitle: Localization.of(context)
                              .settingsDarkThemeDescription,
                          settingKey: "dark_mode",
                        ),
                        // Temporarily removed
                        // SettingListTile<String>(
                        //   values["accent_color"] != null
                        //       ? values["accent_color"]
                        //       : "",
                        //   title: "Accent color",
                        //   settingKey: "accent_color",
                        // ),
                        SettingListTile<List<String>>(
                          currencyCodeList,
                          title: Localization.of(context)
                              .settingsFavoriteCurrencyTitle,
                          settingKey: "favorite_currency",
                          subtitle: Localization.of(context)
                              .settingsFavoriteCurrencyDescription,
                        ),
                        ListTile(
                          title: Text(
                            Localization.of(context).settingsSyncToCloudTitle,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          onTap: () {
                            if (morePrinting) {
                              debugPrint(
                                  "_SettingsPageState.build: Syncing $values");
                            }

                            setState(() {
                              _syncSettingsIcon = CircularProgressIndicator();
                            });
                            var firestoreBloc =
                                BlocProvider.of<FirestoreBloc>(context);

                            if (morePrinting) {
                              debugPrint(
                                  "_SettingsPageState.build: SYNCING... $values");
                            }
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
