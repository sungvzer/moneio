part of 'json_bloc.dart';

@immutable
abstract class JsonEvent {
  final String _fileName;
  final bool createFileIfNeeded;
  JsonEvent(this._fileName, {this.createFileIfNeeded = false});

  get fileName => _fileName;
}

class JsonRead extends JsonEvent {
  JsonRead(fileName) : super(fileName, createFileIfNeeded: false);
}

class JsonClear extends JsonEvent {
  JsonClear(fileName, {createFileIfNeeded = false})
      : super(fileName, createFileIfNeeded: createFileIfNeeded);
}

class JsonWrite extends JsonEvent {
  final dynamic value;
  final bool append;
  JsonWrite(fileName, {this.value, this.append = true}) : super(fileName);
}
