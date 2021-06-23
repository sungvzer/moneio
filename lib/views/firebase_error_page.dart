import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/helpers/constants.dart';

class FirebaseErrorPage extends StatefulWidget {
  static const String id = '/error';

  FirebaseErrorPage();

  @override
  FirebaseErrorPageState createState() => FirebaseErrorPageState();
}

class FirebaseErrorPageState extends State<FirebaseErrorPage> {
  @override
  Widget build(BuildContext context) {
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
          // debugPrint(
          //     "FirebaseErrorPage.build: preferences: ${settings.toString()}");
        }
        return Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Something went wrong starting mone.io, try restarting the application.",
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                    child: Text(
                      "Reload",
                      // style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: () {
                      Phoenix.rebirth(context);
                    },
                  )
                ],
              ),
            ),
          ),
          appBar: AppBar(
            elevation: 0,
            leading: Container(),
            title: Title(
              title: "mone.io",
              color: Theme.of(context).textTheme.headline6!.color!,
              child: Text(
                "mone.io",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6!,
              ),
            ),
          ),
        );
      },
    );
  }
}
