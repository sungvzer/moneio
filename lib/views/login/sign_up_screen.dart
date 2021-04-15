import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/helpers/color_parser.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/helpers/auth/auth_exception_handler.dart';

class SignUpScreen extends StatefulWidget {
  static final String id = "/login/sign_up";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  int _currentStep = 0;
  bool _complete = false;
  bool _passwordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseFirestore store = FirebaseFirestore.instance;

  Map<String, TextEditingController> _controllers = {
    "e-mail": TextEditingController(),
    "password": TextEditingController(),
    "name": TextEditingController(),
    "surname": TextEditingController(),
    "birthday": TextEditingController(
        // text: DateFormat("dd/MM/yyyy").format(DateTime.now()),
        ),
  };

  void _next(List<Step> steps) {
    FormState formState = _formKey.currentState!;
    debugPrint("State: $formState");
    if (!formState.validate()) return;

    if (_currentStep + 1 == steps.length) {
      setState(() => _complete = true);
    } else {
      _goTo(_currentStep + 1);
    }
  }

  void _goTo(int i) {
    setState(() => _currentStep = i);
  }

  void _cancel(BuildContext context) {
    if (_currentStep > 0) {
      _goTo(_currentStep - 1);
    } else {
      Navigator.pop(context);
    }
  }

  void _signUp(context) async {
    String email = _controllers["e-mail"]!.value.text;
    String password = _controllers["password"]!.value.text;
    String name = _controllers["name"]!.value.text.trim();
    String surname = _controllers["surname"]!.value.text.trim();
    Timestamp birthday = Timestamp.fromDate(
      DateFormat("dd/MM/yyyy").parse(
        _controllers["birthday"]!.value.text.trim(),
      ),
    );

    debugPrint(
        "We're complete, signing up with credentials $email - $password");

    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint("New Credentials! ${credential.toString()}");

      await credential.user!.updateProfile(displayName: name);

      // Copy schema to user, and set data.
      FirebaseFirestore store = FirebaseFirestore.instance;
      DocumentSnapshot schema =
          await store.collection("/users/").doc("schema").get();
      Map<String, dynamic> schemaData = schema.data()!;
      schemaData["data"]["firstName"] = name;
      schemaData["data"]["lastName"] = surname;
      schemaData["transactions"] = [];
      schemaData["data"]["birthday"] = birthday;
      await store
          .collection("/users/")
          .doc(credential.user!.uid)
          .set(schemaData);

      await credential.user!.reload();
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      debugPrint("SignUpScreen._next: got an exception.\n${e.message}");
      firebaseAuthExceptionHandler(e, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Step> _signUpSteps = [
      Step(
        isActive: true,
        state: StepState.editing,
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'E-mail Address'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value!.trim().toLowerCase() == "") {
                  return "An e-mail is required to sign up.";
                }
                return null;
              },
              controller: _controllers["e-mail"]!,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
              enableSuggestions: false,
              autocorrect: false,
              keyboardType: TextInputType.text,
              obscureText: !_passwordVisible,
              // Password rules:
              // 1. Should be at least 8 characters long
              // 2. Should contain at least an uppercase letter
              validator: (value) {
                if (value == null) return "A password is required to sign up";

                if (value.isEmpty) return "A password is required to sign up";

                if (value.length > 0 && value.length < 8) {
                  return "Passwords should be at least 8 characters long";
                }
                if (!value.contains(RegExp("[A-Z]+"))) {
                  return "Passwords should contain at least an uppercase letter";
                }

                return null;
              },
              controller: _controllers["password"]!,
            ),
          ],
        ),
        title: const Text("E-mail and password"),
      ),
      Step(
        isActive: true,
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              controller: _controllers["name"]!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Surname'),
              controller: _controllers["surname"]!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: "Birthday"),
              controller: _controllers["birthday"]!,
              readOnly: true,
              onTap: () => showDatePicker(
                context: context,
                firstDate: DateTime(1900, 1, 1),
                lastDate: DateTime.now(),
                initialDate: DateTime.now(),
              ).then((value) {
                final DateFormat f = DateFormat("dd/MM/yyyy");
                var controller = _controllers["birthday"];
                if (controller == null) return;
                if (value == null) {
                  controller.text = "";
                  return;
                }
                controller.text = f.format(value);
              }),
            )
          ],
        ),
        title: const Text("Account information (optional)"),
      ),
    ];

    if (_complete) {
      _signUp(context);
    }

    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: "Poppins",
        color: ColorPalette.ImperialPrimer,
        fontWeight: FontWeight.w500,
        fontSize: 200,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: parseColorString(defaultSettings["accent_color"]),
          elevation: 0,
          // leading: Container(),
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
        body: Center(
          child: Container(
            child: Form(
              key: _formKey,
              child: Stepper(
                physics: BouncingScrollPhysics(),
                onStepContinue: () => _next(_signUpSteps),
                onStepCancel: () => _cancel(context),
                onStepTapped: _goTo,
                currentStep: _currentStep,
                steps: _signUpSteps,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
