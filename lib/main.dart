import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moneio/bloc/firestore/firestore_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/helpers/constants.dart';
import 'package:moneio/generated/l10n.dart';
import 'package:moneio/helpers/themes.dart';
import 'package:moneio/views/firebase_error_page.dart';
import 'package:moneio/views/home/add_transaction_page.dart';
import 'package:moneio/views/home/home_page.dart';
import 'package:moneio/views/home/transaction_view.dart';
import 'package:moneio/views/loading_screen.dart';
import 'package:moneio/views/login/login_screen.dart';
import 'package:moneio/views/login/sign_up_screen.dart';
import 'package:moneio/views/login_router.dart';
import 'package:moneio/views/settings/settings_page.dart';
import 'package:moneio/views/stats/stats_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    Phoenix(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<FirestoreBloc>(
            create: (context) => FirestoreBloc(),
          ),
          BlocProvider<PreferenceBloc>(
            create: (context) => PreferenceBloc(),
          )
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<ThemeNotifier>(
                create: (_) => ThemeNotifier(_)),
          ],
          child: FirebaseApplication(),
        ),
      ),
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
    BlocProvider.of<PreferenceBloc>(context).add(
      PreferenceRead("dark_mode", defaultSettings["dark_mode"]),
    );
    return Consumer<ThemeNotifier>(
      builder: (context, theme, _) => MaterialApp(
        localizationsDelegates: [
          Localization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: Localization.delegate.supportedLocales,
        theme: theme.currentTheme,
        debugShowCheckedModeBanner: true,
        title: "mone.io",
        routes: {
          LoadingScreen.id: (context) => LoadingScreen(),
          HomePage.id: (context) => HomePage(),
          FirebaseErrorPage.id: (context) => FirebaseErrorPage(),
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          AddTransactionPage.id: (context) => AddTransactionPage(),
          SettingsPage.id: (context) => SettingsPage(),
          TransactionView.id: (context) => TransactionView(),
          StatsPage.id: (context) => StatsPage(),
        },
        home: Container(
          color: theme.currentTheme.primaryColor,
          child: SafeArea(
            child: FutureBuilder(
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
                Constants.initializeCategoriesMap(context);
                return LoadingScreen();
              },
            ),
          ),
        ),
      ),
    );
  }
}
