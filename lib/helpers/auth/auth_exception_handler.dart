import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moneio/views/login_router.dart';
import 'package:moneio/views/login_views/login_screen.dart';

void firebaseAuthExceptionHandler(
  FirebaseAuthException authException,
  BuildContext context,
) {
  SnackBar userNotFound = SnackBar(
    content: Text("Wrong e-mail or password. Please retry."),
  );

  // TODO: Handle changes in login and sign up mechanics
  assert(authException.code != "operation-not-allowed");

  switch (authException.code) {
    // TODO: password validation in form instead of here
    case 'weak-password':
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Weak password, please enter a stronger password"),
        ),
      );
      break;

    case 'email-already-in-use':
      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Warning"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("The email is already in use."),
                Text("Would you like to log in?"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                NavigatorState navigator = Navigator.of(context);
                navigator.pop();
                navigator.pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginRouter()));
              },
              child: Text("Log in"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("Cancel"),
            ),
          ],
        ),
      );
      break;

    case 'invalid-email':
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Invalid e-mail address, please enter a valid address and retry",
          ),
        ),
      );
      break;

    case 'user-not-found':
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "No user could be found with that e-mail address.",
          ),
        ),
      );
      break;
    case 'wrong-password':
      ScaffoldMessenger.of(context).showSnackBar(userNotFound);
      break;
    default:
      if (authException.message != null &&
          authException.message!.contains("resolve host")) {
        debugPrint("No connection!");
        break;
      }
  }
}
