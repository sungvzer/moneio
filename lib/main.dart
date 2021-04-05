import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneio/bloc/firestore/firestore_bloc.dart';
import 'package:moneio/bloc/json/json_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/views/firebase_error_page.dart';
import 'package:moneio/views/home/home_page.dart';
import 'package:moneio/views/loading_screen.dart';
import 'package:moneio/views/login_router.dart';
import 'package:moneio/views/login/login_screen.dart';
import 'package:moneio/views/login/sign_up_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<FirestoreBloc>(
          create: (context) => FirestoreBloc(),
        ),
        BlocProvider<JsonBloc>(
          create: (context) => JsonBloc(),
        ),
        BlocProvider<PreferenceBloc>(
          create: (context) => PreferenceBloc(),
        )
      ],
      child: FirebaseApplication(),
    ),
  );
}

class FirebaseApplication extends StatelessWidget {
  static const String id = "/firebaseApplication";
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "mone.io",
      routes: {
        LoadingScreen.id: (context) => LoadingScreen(),
        HomePage.id: (context) => HomePage(),
        FirebaseErrorPage.id: (context) => FirebaseErrorPage(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
      },
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return FirebaseErrorPage();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            if (morePrinting) {
              debugPrint(
                  "FirebaseApplication.build: Firebase initialized, getting application...");
            }
            return LoginRouter();
          }

          return LoadingScreen();
        },
      ),
    );
  }
}
