import 'package:firebase_auth/firebase_auth.dart';

String? get loggedUID => FirebaseAuth.instance.currentUser == null
    ? null
    : FirebaseAuth.instance.currentUser!.uid;
