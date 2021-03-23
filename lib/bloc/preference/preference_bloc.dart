import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preference_event.dart';
part 'preference_state.dart';

class PreferenceBloc extends Bloc<PreferenceEvent, PreferenceState> {
  PreferenceBloc() : super(PreferenceInitial());

  @override
  Stream<PreferenceState> mapEventToState(PreferenceEvent event) async* {
    // debugPrint("PreferenceBloc.mapEventToState: getting type: " +
    // event.runtimeType.toString());
    if (event is PreferenceRead) {
      String key = event.key;
      var value;

      await SharedPreferences.getInstance().then((preferences) async {
        if (key == "") {
          debugPrint("PreferenceBloc.mapEventToState: reading... everything");
          value = <String, dynamic>{};
          for (var x in preferences.getKeys()) {
            value[x] = preferences.get(x);
          }
        } else {
          value = preferences.get(key);
        }
      });

      if (value == null) {
        debugPrint(
            "PreferenceBloc.mapEventToState: hey, we haven't got this kind of key!");
      } else {
        debugPrint("PreferenceBloc.mapEventToState: we've got $value");
      }
      yield PreferenceReadState(value);
    }

    if (event is PreferenceWrite) {
      String key = event.key;
      var value = event.value;
      bool result = false;
      Map<String, dynamic> newValues = {};

      await SharedPreferences.getInstance().then((preferences) async {
        debugPrint(
            "PreferenceBloc.mapEventToState: trying to write $value, of type ${value.runtimeType} into key $key...");
        const List<String> listOfStrings = [""];
        final List<Type> valid = [
          bool,
          int,
          double,
          /* WTF is this shit */ listOfStrings.runtimeType,
          String
        ];
        if (!valid.contains(value.runtimeType)) throw TypeError();

        if (value is bool) result = await preferences.setBool(key, value);

        if (value is Color) {
          String computed = "0x";
          computed += value.alpha.toRadixString(16).padLeft(2, '0');
          computed += value.red.toRadixString(16).padLeft(2, '0');
          computed += value.green.toRadixString(16).padLeft(2, '0');
          computed += value.blue.toRadixString(16).padLeft(2, '0');
          result = await preferences.setString(key, computed);
        }

        if (value is int) result = await preferences.setInt(key, value);

        if (value is double) result = await preferences.setDouble(key, value);

        if (value is List<String>)
          result = await preferences.setStringList(key, value);

        if (value is String) result = await preferences.setString(key, value);
        Set<String> keys = preferences.getKeys();
        for (key in keys) {
          newValues[key] = preferences.get(key);
        }
      });
      debugPrint(
          "PreferenceBloc.mapEventToState: ${result ? "success!" : "failure!"}");
      debugPrint("PreferenceBloc.mapEventToState: updated values: $newValues");
      yield PreferenceWriteState(
        success: result,
        updatedPreferences: newValues,
      );
    }
  }
}
