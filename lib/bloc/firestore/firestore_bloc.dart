import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moneio/models/transaction.dart' as UserTransaction
    show Transaction;

part 'firestore_event.dart';

part 'firestore_state.dart';

class FirestoreBloc extends Bloc<FirestoreEvent, FirestoreState> {
  late final FirebaseFirestore _store;

  FirestoreBloc() : super(FirestoreInitial()) {
    _store = FirebaseFirestore.instance;
  }

  Future<Map> _getUserDocument(String uid) async {
    debugPrint(
        "FirestoreBloc._getUserDocument: Getting user document for user $uid");
    CollectionReference users = _store.collection("/users");
    DocumentReference userDocument = users.doc("/$uid");

    DocumentSnapshot userSnapshot = await userDocument.get();
    if (userSnapshot.metadata.isFromCache) {
      debugPrint("FirestoreBloc._getUserDocument: Got document from cache.");
    }
    var userDocumentData;
    try {
      userDocumentData = userSnapshot.data();
    } on StateError {
      debugPrint(
          "FirestoreBloc._getUserDocument: document does not exist! We need to do something about this.");
    }
    assert(userDocumentData != null);

    debugPrint(
        "FirestoreBloc._getUserDocument: got document!\n$userDocumentData");

    if (userDocumentData is! Map) {
      throw UnimplementedError("Document is not a map.. what happened?");
    }
    return userDocumentData;
  }

  // TODO: Parse this list to a list of transactions
  Future<List<UserTransaction.Transaction>> _getUserTransactions(
      String uid, bool Function(UserTransaction.Transaction)? filter) async {
    List? mapList = (await _getUserDocument(uid))["transactions"];
    if (mapList == null || mapList == [])
      return <UserTransaction.Transaction>[];
    List<UserTransaction.Transaction> transactions = [];

    debugPrint("FirestoreBloc._getUserTransactions: $mapList");
    for (var map in mapList) {
      assert(map is Map);
      transactions.add(UserTransaction.Transaction.fromMap(map));
    }

    if (filter != null) transactions.removeWhere((element) => !filter(element));

    return transactions;
  }

  Future<Map> _getUserData(String uid) async {
    return (await _getUserDocument(uid))["data"] as Map;
  }

  Future<Map> _getUserSettings(String uid) async {
    return (await _getUserDocument(uid))["settings"] as Map;
  }

  @override
  Stream<FirestoreState> mapEventToState(FirestoreEvent event) async* {
    debugPrint("FirestoreBloc.mapEventToState: got ${event.runtimeType}");

    if (event is FirestoreGet) {
      FirestoreGetType type = event.type;
      String uid = event.userUid;
      debugPrint('FirestoreBloc.mapEventToState: Type is $type');
      switch (type) {
        case FirestoreGetType.UserTransactions:
          // TODO: Success is always true, this is not always the case :^)
          yield FirestoreReadState(
            success: true,
            type: type,
            data: await _getUserTransactions(uid, event.transactionFilter),
          );
          break;

        case FirestoreGetType.UserSettings:
          // TODO: Success is always true, this is not always the case :^)
          yield FirestoreReadState(
            success: true,
            type: type,
            data: await _getUserSettings(uid),
          );
          break;
        case FirestoreGetType.UserData:
          // TODO: Success is always true, this is not always the case :^)
          yield FirestoreReadState(
            success: true,
            type: type,
            data: await _getUserData(uid),
          );
          break;
        case FirestoreGetType.UserDocument:
          // TODO: Success is always true, this is not always the case :^)
          yield FirestoreReadState(
            success: true,
            type: type,
            data: await _getUserDocument(uid),
          );
          break;
        default:
          throw UnimplementedError("This bloc is not done yet");
      }
    }
  }
}
