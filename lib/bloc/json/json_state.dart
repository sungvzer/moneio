part of 'json_bloc.dart';

class JsonState {
  final bool isError;
  final String message;
  bool hasValue;
  final dynamic value;

  JsonState({this.isError, this.message, this.value}) {
    hasValue = value != null;
  }
}
