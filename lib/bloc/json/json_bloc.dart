import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

part 'json_event.dart';
part 'json_state.dart';

class JsonBloc extends Bloc<JsonEvent, JsonState> {
  JsonBloc() : super(JsonState(isError: false, message: "Initial state"));

  @override
  Stream<JsonState> mapEventToState(JsonEvent event) async* {
    // Code that's used in both codepaths
    Directory d = await getApplicationDocumentsDirectory();
    File activeFile;
    String fileName = event.fileName, fullPath = d.path + "/$fileName";
    activeFile = File(fullPath);

    // If we're debugging delete every json file
    // if (kDebugMode) {
    //   List<FileSystemEntity> entries = d.listSync();
    //   for (var entity in entries) {
    //     if (entity.absolute.path.contains("json")) {
    //       entity.deleteSync();
    //     }
    //   }
    // }

    // TODO: Do we create it if we only need to write from it?
    // Or do we return a JSONState with isError?
    // Actually create a new file if we need one.
    if (!activeFile.existsSync()) {
      activeFile.createSync(recursive: true);
    }

    // If in debug mode, load a dummy file.
    if (kDebugMode) {
      // TODO: Comments
      // debugPrint("Loading dummy string...");
      // const String dummy =
      //     '[{"id": 0,"tag": "Pizza","icon": "🍕","amount": -15.0,"currency": "USD","date": "2020-07-30T22:32"},{"id": 1,"tag": "Games","icon": "🎮","amount": -32.0,"currency": "USD","date": "2020-07-23T22:32"},{"id": 2,"tag": "Trip to Rome","icon": "🛫","amount": -30.0,"currency": "USD","date": "2020-07-20T22:32"},{"id": 3,"tag": "Work Salary","icon": "💼","amount": 1250.37,"currency": "USD","date": "2020-07-17T22:32"},{"id": 4,"tag": "Electricity Bill","icon": "💡","amount": -250.0,"currency": "USD","date": "2020-07-13T22:32"},{"id": 5,"tag": "Water Bill","icon": "💧","amount": -150.0,"currency": "USD","date": "2020-07-10T22:32"},{"id": 3,"tag": "Rent","icon": "🏠","amount": -500.0,"currency": "USD","date": "2020-07-10T22:32"},{"id": 3,"tag": "Phone&Internet","icon": "📞","amount": -30.0,"currency": "USD","date": "2020-07-05T22:32"}]';
      // activeFile.writeAsStringSync(dummy);
    }
    assert(activeFile != null);
    assert(activeFile.existsSync());

    // Codepaths
    if (event is JsonRead) {
      yield _read(activeFile);
    } else if (event is JsonWrite) {
      yield _write(
          activeFile, event.value != null ? event.value : "", event.append);
    }
  }

  JsonState _write(File activeFile, value, bool append) {
    activeFile.writeAsStringSync(jsonEncode(value),
        mode: append ? FileMode.append : FileMode.write);
    // debugPrint(activeFile.lastModifiedSync().toString());
    return JsonState(
        isError: false, message: "Written contents to ${activeFile.path}");
  }

  JsonState _read(File activeFile) {
    var decoded;
    String buffer = activeFile.readAsStringSync();

    // Empty file
    if (buffer == '') {
      return JsonState(isError: false, value: []);
    } else {
      try {
        decoded = json.decode(buffer);
        return JsonState(isError: false, value: decoded);
      } catch (e, trace) {
        String msgString = "Could not decode ${activeFile.path}";
        debugPrint(msgString + "\n$trace");
        return JsonState(isError: true, message: msgString);
      }
    }
  }
}
