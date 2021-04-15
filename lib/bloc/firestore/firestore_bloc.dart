import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/helpers/convert_case.dart';
import 'package:moneio/models/transaction.dart' as UserTransaction
    show Transaction;

part 'firestore_event.dart';
part 'firestore_state.dart';

class FirestoreBloc extends Bloc<FirestoreEvent, FirestoreState> {
  late final FirebaseFirestore _store;
  static Map<String, Map<String, dynamic>> _userCaches = {};
  bool _isCacheValid = false;

  FirestoreBloc() : super(FirestoreInitial()) {
    _store = FirebaseFirestore.instance;
  }

  Future<Map> _getUserDocument(String uid) async {
    if (_isCacheValid) {
      debugPrint(
          "FirestoreBloc._getUserDocument: Getting user document from cache.");
      assert(_userCaches[uid] != null);
      return _userCaches[uid]!;
    }
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

    if (morePrinting)
      debugPrint(
          "FirestoreBloc._getUserDocument: got document!\n$userDocumentData");

    if (userDocumentData is! Map) {
      throw UnimplementedError("Document is not a map.. what happened?");
    }

    _isCacheValid = true;
    _userCaches[uid] = userDocumentData as Map<String, dynamic>;
    return userDocumentData;
  }

  Future<List<UserTransaction.Transaction>> _getUserTransactions(
      String uid, bool Function(UserTransaction.Transaction)? filter) async {
    List? mapList = (await _getUserDocument(uid))["transactions"];
    if (mapList == null || mapList == [])
      return <UserTransaction.Transaction>[];
    List<UserTransaction.Transaction> transactions = [];

    if (false) debugPrint("FirestoreBloc._getUserTransactions: $mapList");
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

  Future<FirestoreReadState> _handleRead(
    FirestoreReadType type,
    String uid,
    bool Function(UserTransaction.Transaction)? filter,
  ) async {
    var data;
    bool success;
    switch (type) {
      case FirestoreReadType.UserDocument:
        data = await _getUserDocument(uid);
        success = true;
        break;

      case FirestoreReadType.UserSettings:
        data = await _getUserSettings(uid);
        success = true;
        break;

      case FirestoreReadType.UserTransactions:
        data = await _getUserTransactions(uid, filter);
        success = true;
        break;

      case FirestoreReadType.UserData:
        data = await _getUserData(uid);
        success = true;
        break;

      default:
        success = false;
        data = null;
        break;
    }
    success = true;
    return FirestoreReadState(success: success, type: type, data: data);
  }

  Future<FirestoreWriteState> _handleWrite(
      FirestoreWriteType type, String uid, data) async {
    _isCacheValid = false;
    CollectionReference users = _store.collection("/users");
    DocumentReference userDocumentReference = users.doc("/$uid");

    Map<String, dynamic> userDocument =
        await _getUserDocument(uid) as Map<String, dynamic>;

    bool success = false;

    if (false) debugPrint("FirestoreBloc._handleSet: Data is $userDocument");
    switch (type) {
      case FirestoreWriteType.SyncUserSettings:
        assert(data is Map);
        var remoteSettings = userDocument["settings"]! as Map<String, dynamic>;
        var localSettings = {};

        // This addresses inconsistencies between local code and remote data.
        data.keys.forEach((element) {
          localSettings[snakeToCamelCase(element)] = data[element]!;
        });

        // Try and avoid settings deletion.
        var mergedSettings = {
          ...remoteSettings,
          ...localSettings,
        };
        userDocument["settings"] = mergedSettings;
        await userDocumentReference.set(
          userDocument,
          SetOptions(merge: true),
        );
        success = true;
        break;
      case FirestoreWriteType.ResetSingleUserSetting:
        assert(data == null);
        var defaultSettingsToCamelCase = {};

        defaultSettings.keys.forEach((element) {
          defaultSettingsToCamelCase[snakeToCamelCase(element)] =
              defaultSettings[element]!;
        });
        userDocument["settings"] = defaultSettingsToCamelCase;

        await userDocumentReference.set(
          userDocument,
          SetOptions(merge: true),
        );
        break;
      case FirestoreWriteType.AddSingleUserTransaction:
        assert(data is UserTransaction.Transaction);
        UserTransaction.Transaction transaction =
            data as UserTransaction.Transaction;
        List transactions = [];
        if (!userDocument.containsKey("transactions")) {
          userDocument["transactions"] = transactions;
        } else {
          transactions = userDocument["transactions"];
        }

        transactions.forEach((element) {
          assert(element is Map);
        });
        Timestamp timestamp = Timestamp.fromDate(transaction.date);

        Map<String, dynamic> transactionToMap = transaction.toMap();
        transactionToMap["date"] = timestamp;
        transactions.add(transactionToMap);
        userDocument["transactions"] = transactions;

        await userDocumentReference.set(userDocument, SetOptions(merge: true));
        success = true;
        debugPrint("FirestoreBloc._handleWrite: Transactions is $transactions");
        break;
      case FirestoreWriteType.RemoveSingleUserTransaction:
        assert(data is String);
        String transactionId = data as String;

        List transactions = [];
        if (!userDocument.containsKey("transactions")) {
          userDocument["transactions"] = transactions;
        } else {
          transactions = userDocument["transactions"];
        }

        int lengthBeforeRemoving = transactions.length;
        transactions
            .removeWhere((element) => (element as Map)["id"] == transactionId);
        int lengthAfterRemoving = transactions.length;

        assert(lengthAfterRemoving <= lengthBeforeRemoving,
            "Something horrible happened");
        if (lengthAfterRemoving < lengthBeforeRemoving) {
          userDocument["transactions"] = transactions;
          await userDocumentReference.set(
              userDocument, SetOptions(merge: true));
        } else {
          debugPrint(
              "FirestoreBloc._handleWrite: We didn't really remove anything");
        }
        success = true;
        break;
      case FirestoreWriteType.UpdateUserData:
        assert(data is Map);
        var userData = await _getUserData(uid) as Map<String, dynamic>;
        final mergedMap = {
          ...userData,
          ...data,
        };
        userDocument["data"] = mergedMap;
        await userDocumentReference.set(userDocument, SetOptions(merge: true));
        success = true;
        break;
    }

    // userDocument.set(userDocument, SetOptions(merge: true));
    return FirestoreWriteState(
        success: success, type: type, updatedDocument: userDocument);
  }

  @override
  Stream<FirestoreState> mapEventToState(FirestoreEvent event) async* {
    debugPrint("FirestoreBloc.mapEventToState: got ${event.runtimeType}");

    if (event is FirestoreRead) {
      FirestoreReadType type = event.type;
      debugPrint('FirestoreBloc.mapEventToState: Type is $type');
      String uid = event.userId;
      yield await _handleRead(type, uid, event.transactionFilter);
    } else if (event is FirestoreWrite) {
      FirestoreWriteType type = event.type;
      debugPrint('FirestoreBloc.mapEventToState: Type is $type');
      String uid = event.userId;
      yield await _handleWrite(type, uid, event.data);
    }
  }
}
