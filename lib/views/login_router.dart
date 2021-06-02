import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/views/firebase_error_page.dart';
import 'package:moneio/views/home/home_page.dart';
import 'package:moneio/views/loading_screen.dart';
import 'package:moneio/views/login/login_screen.dart';

class LoginRouter extends StatelessWidget {
  static final String id = '/login_router';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) return FirebaseErrorPage();

        if (morePrinting) {
          debugPrint(
              "LoginRouter.build: ConnectionState: ${snapshot.connectionState.toString()}");
        }

        if (snapshot.connectionState != ConnectionState.active) {
          return LoadingScreen();
        }
        User? user = snapshot.data;

        if (user == null) {
          PreferenceBloc bloc = BlocProvider.of<PreferenceBloc>(context);
          for (var preference in defaultSettings.entries) {
            bloc.add(PreferenceWrite(preference.key, preference.value));
          }
          if (morePrinting) {
            debugPrint("LoginRouter.build: user is not logged in");
          }
          return LoginScreen();
        }

        if (morePrinting) {
          debugPrint("LoginRouter.build: user is logged in");
          debugPrint(user.toString());
        }
        return HomePage();
      },
    );
  }
}
