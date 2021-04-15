part of 'firestore_bloc.dart';

@immutable
abstract class FirestoreState {}

class FirestoreInitial extends FirestoreState {}

class FirestoreReadState extends FirestoreState {
  final bool success;
  final FirestoreReadType type;
  final data;
  late final bool hasData;

  FirestoreReadState({
    required this.success,
    required this.type,
    required this.data,
  }) {
    hasData = data != null;
  }
}

class FirestoreWriteState extends FirestoreState {
  final bool success;
  final FirestoreWriteType type;
  final updatedDocument;
  late final bool hasUpdatedDocument;

  FirestoreWriteState({
    required this.success,
    required this.type,
    this.updatedDocument,
  }) {
    hasUpdatedDocument = this.updatedDocument != null;
  }
}
