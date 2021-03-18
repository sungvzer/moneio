part of 'preference_bloc.dart';

@immutable
abstract class PreferenceEvent {}

class PreferenceRead extends PreferenceEvent {
  late String key;
  PreferenceRead([String? key]) {
    if (key == null) {
      this.key = "";
    }
  }
}

class PreferenceWrite<T> extends PreferenceEvent {
  final String key;
  final T value;
  PreferenceWrite(this.key, this.value);
}
