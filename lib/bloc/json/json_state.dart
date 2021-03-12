part of 'json_bloc.dart';

class JsonState {
  final bool isError;
  final String message;
  late bool hasValue;
  final dynamic value;

  JsonState({this.isError = false, this.message = "", this.value}) {
    hasValue = value != null;
  }

  @override
  String toString() {
    return "State (isError: $isError, message: $message, value: $value)";
  }
}

class JsonReadState extends JsonState {
  JsonReadState({isError = false, message = "", value = ""})
      : super(isError: isError, message: message, value: value);
}

class JsonWriteState extends JsonState {
  JsonWriteState({isError = false, message, value})
      : super(isError: isError, message: message, value: value);
}
