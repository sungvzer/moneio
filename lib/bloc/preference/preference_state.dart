part of 'preference_bloc.dart';

@immutable
abstract class PreferenceState {}

class PreferenceInitial extends PreferenceState {}

class PreferenceReadState extends PreferenceState {
  final readValue;

  PreferenceReadState(this.readValue);
}

class PreferenceWriteState extends PreferenceState {
  final bool success;
  final Map<String, dynamic> updatedPreferences;

  PreferenceWriteState(
      {required this.success, required this.updatedPreferences});
}
