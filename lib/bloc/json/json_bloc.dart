import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
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

    if (event is JsonRead) {
      assert(event.fileName != null);
      String buffer;
      var decoded;

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

      // File is open, we try to read from it and decode the string
      buffer = await activeFile.readAsString();

      try {
        decoded = jsonDecode(buffer);
      } catch (e, trace) {
        state = JsonState(
          isError: true,
          message: "Could not decode file ${event.fileName}",
        );
        debugPrint("Could not decode file ${event.fileName}.\n$trace");
        yield state;
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
