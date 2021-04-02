import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/color_parser.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/views/login_views/sign_up_screen.dart';
import 'package:moneio/widgets/labelled_form_field.dart';
import 'package:moneio/helpers/auth/auth_exception_handler.dart';

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
      body: DefaultTextStyle(
        style: TextStyle(
          fontFamily: "Poppins",
          color: ColorPalette.ImperialPrimer,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        child: Container(
          alignment: Alignment.center,
          child: LoginForm(),
        ),
      ),
      appBar: AppBar(
        backgroundColor: parseColorString(defaultSettings["accent_color"]),
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
  }
}

class LoginForm extends StatefulWidget {
  LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _passwordVisible = false;

  static const TextStyle _defaultStyle = TextStyle(
    fontFamily: "Poppins",
    color: ColorPalette.ImperialPrimer,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  final Map<String, TextEditingController> _controllers = {
    "email": TextEditingController(),
    "password": TextEditingController(),
  };
  final GlobalKey<FormState> loginFormKey =
      GlobalKey<FormState>(debugLabel: "LoginForm");

  void _login(context) async {
    if (!loginFormKey.currentState!.validate()) return;
    String email, password;
    email = _controllers["email"]!.value.text;
    password = _controllers["password"]!.value.text;

    FirebaseAuth auth = FirebaseAuth.instance;
    debugPrint("LoginScreen.build._login: trying to login!");
    try {
      debugPrint("LoginForm: login with $email - $password");
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      debugPrint("LoginForm: logged in $email - $password");
    } on FirebaseAuthException catch (e) {
      debugPrint("LoginScreen.build._login: got an exception.\n${e.message}");

      firebaseAuthExceptionHandler(e, context);
    }
    debugPrint("LoginScreen.build._login: after the login!");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: _defaultStyle,
      child: SingleChildScrollView(
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
                    "E-mail",
                    child: TextFormField(
                      controller: _controllers["email"],
                      keyboardType: TextInputType.emailAddress,
                      style: _defaultStyle,
                      autofillHints: [AutofillHints.email],
                      validator: (value) {
                        if (value!.trim().toLowerCase() == "") {
                          return "An e-mail is required to login";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  LabelledFormField(
                    "Password",
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
                            color: ColorPalette.ImperialPrimer,
                          ),
                        ),
                      ),
                      controller: _controllers["password"],
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.text,
                      obscureText: !_passwordVisible,
                      autofillHints: [AutofillHints.password],
                      style: _defaultStyle,
                      validator: (value) {
                        if (value! == "") {
                          return "A password is required to login";
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
                      "Login",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(100, 0)),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                            width: 2, color: ColorPalette.ImperialPrimer),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          parseColorString(defaultSettings["accent_color"])),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          ColorPalette.ImperialPrimer),
                    ),
                    onPressed: () => _login(context),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(100, 0)),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                            width: 2, color: ColorPalette.ImperialPrimer),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          ColorPalette.ImperialPrimer),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
