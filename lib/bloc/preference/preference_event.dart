part of 'preference_bloc.dart';

@immutable
abstract class PreferenceEvent {}

class PreferenceRead extends PreferenceEvent {
  late final String key;
  late final defaultValue;

  PreferenceRead([String? key, var defaultValue]) {
    this.defaultValue = defaultValue;

    if (key == null) {
      this.key = "";
    } else {
      this.key = key;
    }
  }
}

class PreferenceWrite<T> extends PreferenceEvent {
  final String key;
  final T value;

  PreferenceWrite(this.key, this.value);
}
