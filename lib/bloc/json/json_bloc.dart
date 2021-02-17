import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'json_event.dart';
part 'json_state.dart';

class JsonBloc extends Bloc<JsonEvent, JsonState> {
  JsonBloc() : super(JsonState(isError: false, message: "Initial state"));

  @override
  Stream<JsonState> mapEventToState(JsonEvent event) async* {
    JsonState state;
    File activeFile;

    // If we're debugging delete every json file
    // if (kDebugMode) {
    //   List<FileSystemEntity> entries = d.listSync();
    //   for (var entity in entries) {
    //     if (entity.absolute.path.contains("json")) {
    //       entity.deleteSync();
    //     }
    //   }
    // }

      // Catch errors in opening a file
      try {
        activeFile = File(event.fileName);
      } catch (e, trace) {
        state = JsonState(
          isError: true,
          message: "Could not open file ${event.fileName}",
        );
        debugPrint("Could not open file ${event.fileName}.\n$trace");
        yield state;
      }

    // If in debug mode, load a dummy file.
    if (kDebugMode) {
      // TODO: Comments
      // debugPrint("Loading dummy string...");
      // const String dummy =
      //     '[{"id": 0,"tag": "Pizza","icon": "🍕","amount": -15.0,"currency": "USD","date": "2020-07-30T22:32"},{"id": 1,"tag": "Games","icon": "🎮","amount": -32.0,"currency": "USD","date": "2020-07-23T22:32"},{"id": 2,"tag": "Trip to Rome","icon": "🛫","amount": -30.0,"currency": "USD","date": "2020-07-20T22:32"},{"id": 3,"tag": "Work Salary","icon": "💼","amount": 1250.37,"currency": "USD","date": "2020-07-17T22:32"},{"id": 4,"tag": "Electricity Bill","icon": "💡","amount": -250.0,"currency": "USD","date": "2020-07-13T22:32"},{"id": 5,"tag": "Water Bill","icon": "💧","amount": -150.0,"currency": "USD","date": "2020-07-10T22:32"},{"id": 3,"tag": "Rent","icon": "🏠","amount": -500.0,"currency": "USD","date": "2020-07-10T22:32"},{"id": 3,"tag": "Phone&Internet","icon": "📞","amount": -30.0,"currency": "USD","date": "2020-07-05T22:32"}]';
      // activeFile.writeAsStringSync(dummy);
    }

      state = JsonState(isError: false, value: decoded);
    } else if (event is JsonWrite) {
      assert(event.fileName != null && event.value != null);

      // Catch errors in opening a file (created if it doesn't exist)
      try {
        activeFile = await File(event.fileName).create(recursive: true);
      } catch (e, trace) {
        state = JsonState(
          isError: true,
          message: "Could not create file ${event.fileName}",
        );
        debugPrint("Could not create file ${event.fileName}.\n$trace");
        yield state;
      }

      // Convert the value to a JSON string and try to write it to the file
      String valueToString = jsonEncode(event.value);
      try {
        await activeFile.writeAsString(valueToString);
        state =
            JsonState(isError: false, message: "Written value: ${event.value}");
      } catch (e, trace) {
        state = JsonState(isError: true, message: "Could not write to file");
        debugPrint("Error writing to file ${event.fileName}.\n$trace");
        yield state;
      }
    }
    yield state;
  }
}
