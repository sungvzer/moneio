import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneio/views/firebase_error_page.dart';
import 'package:moneio/views/home_page.dart';
import 'package:moneio/views/loading_screen.dart';
import 'package:moneio/views/login_views/login_screen.dart';

class LoginRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) return FirebaseErrorPage();
        debugPrint(
            "LoginRouter.build: ConnectionState: ${snapshot.connectionState.toString()}");
        if (snapshot.connectionState != ConnectionState.active) {
          return LoadingScreen();
        }
        final user = snapshot.data;
        if (user != null) {
          debugPrint("LoginRouter.build: user is logged in");
          debugPrint((user as User?).toString());
          if (false)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          return HomePage();
        } else {
          debugPrint("LoginRouter.build: user is not logged in");

          if (false)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          return LoginScreen();
        }
      },
    );
  }
}
