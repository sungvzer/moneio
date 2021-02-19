part of 'json_bloc.dart';

@immutable
abstract class JsonEvent {
  final String _fileName;
  JsonEvent(this._fileName);

  get fileName => _fileName;
}

class JsonRead extends JsonEvent {
  JsonRead(fileName) : super(fileName);
}

class JsonClear extends JsonEvent {
  JsonClear(fileName) : super(fileName);
}

class JsonWrite extends JsonEvent {
  final dynamic value;
  final bool append;
  JsonWrite(fileName, {this.value, this.append = true}) : super(fileName);
}
