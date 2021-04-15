import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/helpers/color_parser.dart';
import 'package:moneio/constants.dart';

class FirebaseErrorPage extends StatefulWidget {
  static const String id = '/error';

  FirebaseErrorPage();

  @override
  FirebaseErrorPageState createState() => FirebaseErrorPageState();
}

class FirebaseErrorPageState extends State<FirebaseErrorPage> {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: DefaultTextStyle(
    //     style: TextStyle(
    //       fontFamily: "Poppins",
    //       color: ColorPalette.ImperialPrimer,
    //       fontWeight: FontWeight.w600,
    //       fontSize: 16,
    //     ),
    //     child: Container(
    //       alignment: Alignment.center,
    //       child: Center(
    //         child: Text(
    //           "Something went wrong starting mone.io, try restarting the application.",
    //           textAlign: TextAlign.center,
    //         ),
    //       ),
    //     ),
    //   ),
    //   appBar: AppBar(
    //     backgroundColor: accentColor,
    //     elevation: 0,
    //     leading: Container(),
    //     centerTitle: true,
    //     title: Title(
    //       title: "mone.io",
    //       color: ColorPalette.ImperialPrimer,
    //       child: Text(
    //         "mone.io",
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //           fontSize: 26,
    //           color: ColorPalette.ImperialPrimer,
    //           fontFamily: "Poppins",
    //           fontWeight: FontWeight.w900,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    debugPrint("FirebaseErrorPageState.build: Adding PreferenceRead...");

    BlocProvider.of<PreferenceBloc>(context)
        .add(PreferenceRead("", defaultSettings));
    return BlocBuilder<PreferenceBloc, PreferenceState>(
      builder: (context, state) {
        Map<String, dynamic> settings = {};
        if (state is PreferenceReadState ||
            (state is PreferenceWriteState && state.success)) {
          // TODO: Handle settings not existing
          if (state is PreferenceReadState) {
            try {
              settings = Map<String, dynamic>.from(state.readValue);
            } catch (e) {
              debugPrint(
                  "Call an ambulance call an ambulance, but not for me!");
              return CircularProgressIndicator();
            }
          } else {
            settings = (state as PreferenceWriteState).updatedPreferences;
            if (settings == {}) throw UnimplementedError();
          }
          debugPrint(
              "AddTransactionPageState.build: preferences: ${settings.toString()}");
        }
        return Scaffold(
          body: DefaultTextStyle(
            style: TextStyle(
              fontFamily: "Poppins",
              color: ColorPalette.ImperialPrimer,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            child: Container(
              alignment: Alignment.center,
              child: Center(
                child: Text(
                  "Something went wrong starting mone.io, try restarting the application.",
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: settings["accent_color"] != null
                ? parseColorString(settings["accent_color"])
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
        );
      },
    );
  }
}
