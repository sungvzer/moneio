part of 'json_bloc.dart';

@immutable
abstract class JsonEvent {}

class JsonRead extends JsonEvent {
  final String fileName;
  JsonRead({this.fileName});
}

class JsonWrite extends JsonEvent {
  final String fileName;
  final dynamic value;
  JsonWrite({this.fileName, this.value});
}
