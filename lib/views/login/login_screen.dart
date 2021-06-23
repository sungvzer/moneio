import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:moneio/bloc/firestore/firestore_bloc.dart';
import 'package:moneio/bloc/preference/preference_bloc.dart';
import 'package:moneio/generated/l10n.dart';
import 'package:moneio/helpers/auth/auth_exception_handler.dart';
import 'package:moneio/views/login/sign_up_screen.dart';
import 'package:moneio/widgets/labelled_form_field.dart';

class LoginScreen extends StatefulWidget {
  static const String id = '/login';

  LoginScreen();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        child: LoginForm(),
      ),
      appBar: AppBar(
        // backgroundColor:
        elevation: 0,
        leading: Container(),
        centerTitle: true,
        title: Title(
          title: Localization.of(context).appName,
          color: Theme.of(context).primaryColor,
          child: Text(
            Localization.of(context).appName,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline6!,
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _passwordVisible = false;

  final Map<String, TextEditingController> _controllers = {
    "email": TextEditingController(),
    "password": TextEditingController(),
  };
  final GlobalKey<FormState> loginFormKey =
      GlobalKey<FormState>(debugLabel: "LoginForm");

  final GlobalKey<FormFieldState> emailKey =
      GlobalKey<FormFieldState>(debugLabel: "LoginForm");

  void _login(context) async {
    if (!loginFormKey.currentState!.validate()) return;
    String email, password;
    email = _controllers["email"]!.value.text;
    password = _controllers["password"]!.value.text;
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential credential;
    debugPrint("LoginScreen.build._login: trying to login!");
    try {
      debugPrint("LoginForm: login with $email - $password");
      credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint("LoginForm: logged in $email - $password");
    } on FirebaseAuthException catch (e) {
      debugPrint("LoginScreen.build._login: got an exception.\n${e.message}");

      firebaseAuthExceptionHandler(e, context);
      return;
    }

    debugPrint(
        "LoginScreen.build._login: credential.uid -> ${credential.user!.uid}");

    FirestoreBloc bloc = BlocProvider.of<FirestoreBloc>(context);
    // Update user document at login
    bloc
      ..add(
        FirestoreWrite(
          type: FirestoreWriteType.InvalidateCache,
          userId: credential.user!.uid,
          data: null,
        ),
      )
      ..add(FirestoreSyncSettings(
        BlocProvider.of<PreferenceBloc>(context),
        type: FirestoreSyncType.FetchRemoteSettings,
        userId: credential.user!.uid,
      ));
    debugPrint("LoginScreen.build._login: after the login!");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Form(
        key: loginFormKey,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: AutofillGroup(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LabelledFormField(
                  Localization.of(context).loginEmailAddress,
                  child: TextFormField(
                    key: emailKey,
                    controller: _controllers["email"],
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context).textTheme.bodyText2!,
                    autofillHints: [AutofillHints.email],
                    validator: (value) {
                      if (value!.trim().toLowerCase() == "") {
                        return Localization.of(context).loginEmailRequired;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                LabelledFormField(
                  Localization.of(context).loginPassword,
                  child: TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color:
                              Theme.of(context).inputDecorationTheme.focusColor,
                        ),
                      ),
                    ),
                    controller: _controllers["password"],
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.text,
                    obscureText: !_passwordVisible,
                    autofillHints: [AutofillHints.password],
                    style: Theme.of(context).textTheme.bodyText2!,
                    validator: (value) {
                      if (value! == "") {
                        return Localization.of(context).loginPasswordRequired;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                // Checkbox(
                //     value: false,
                //     onChanged: (value) {
                //       debugPrint("Remember me is $value");
                //     }),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text(
                    Localization.of(context).loginContinue,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins"),
                  ),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(150, 0)),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(
                        width: 2,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).backgroundColor,
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).textTheme.bodyText2!.color!,
                    ),
                  ),
                  onPressed: () => _login(context),
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  child: Text(
                    Localization.of(context).loginSignUp,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Poppins"),
                  ),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all<Size>(Size(150, 0)),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      BorderSide(
                        width: 2,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).backgroundColor,
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).textTheme.bodyText2!.color!,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpScreen.id);
                  },
                ),
                TextButton(
                  onPressed: () {
                    FormFieldState? state = emailKey.currentState;
                    if (state == null) {
                      return;
                    }
                    if (!state.validate()) {
                      return;
                    }
                    try {
                      FirebaseAuth.instance
                          .sendPasswordResetEmail(email: state.value);
                    } on Exception {
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(Localization.of(context)
                            .loginCheckEmailForPasswordReset),
                      ),
                    );
                  },
                  child: Text(
                    Localization.of(context).loginPasswordReset,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
