part of 'firestore_bloc.dart';

enum FirestoreGetType {
  UserDocument,
  UserSettings,
  UserTransactions,
  UserData,
}

@immutable
abstract class FirestoreEvent {}

class FirestoreGet extends FirestoreEvent {
  final FirestoreGetType type;
  final String userUid;
  late final bool Function(UserTransaction.Transaction)? transactionFilter;

  FirestoreGet({
    required this.type,
    required this.userUid,
    this.transactionFilter,
  }) {
    if (transactionFilter != null) {
      assert(this.type == FirestoreGetType.UserTransactions,
          "Getting a transactionFilter with an incompatible FirestoreGetType.");
    }
  }
}
