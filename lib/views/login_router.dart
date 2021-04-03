import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/views/firebase_error_page.dart';
import 'package:moneio/views/home_page.dart';
import 'package:moneio/views/loading_screen.dart';
import 'package:moneio/views/login/login_screen.dart';

class LoginRouter extends StatelessWidget {
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
