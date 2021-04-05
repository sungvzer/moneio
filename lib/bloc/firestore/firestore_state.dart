part of 'firestore_bloc.dart';

@immutable
abstract class FirestoreState {}

class FirestoreInitial extends FirestoreState {}

class FirestoreReadState extends FirestoreState {
  final bool success;
  final FirestoreGetType type;
  final data;
  late final bool hasData;

  FirestoreReadState(
      {required this.success, required this.type, required this.data}) {
    hasData = data != null;
  }
}
