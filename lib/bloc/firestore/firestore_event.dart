part of 'firestore_bloc.dart';

enum FirestoreReadType {
  UserDocument,
  UserSettings,
  UserTransactions,
  UserData,
}

enum FirestoreWriteType {
  SyncUserSettings,
  EditSingleUserTransaction,
  ResetSingleUserSetting,
  AddSingleUserTransaction,
  RemoveSingleUserTransaction,
  UpdateUserData,
  InvalidateCache
}

enum FirestoreSyncType { UploadLocalSettings, FetchRemoteSettings }

@immutable
abstract class FirestoreEvent {}

class FirestoreRead extends FirestoreEvent {
  final FirestoreReadType type;
  final String userId;
  late final bool Function(UserTransaction.Transaction)? transactionFilter;

  FirestoreRead({
    required this.type,
    required this.userId,
    this.transactionFilter,
  }) {
    if (transactionFilter != null) {
      assert(this.type == FirestoreReadType.UserTransactions,
          "Getting a transactionFilter with an incompatible FirestoreGetType.");
    }
  }
}

class FirestoreWrite extends FirestoreEvent {
  final FirestoreWriteType type;
  final String userId;
  final data;

  FirestoreWrite(
      {required this.type, required this.userId, required this.data});
}

class FirestoreSyncSettings extends FirestoreEvent {
  final FirestoreSyncType type;
  final String userId;
  final Map<String, dynamic>? data;
  final PreferenceBloc bloc;

  FirestoreSyncSettings(this.bloc,
      {required this.type, required this.userId, this.data});
}
