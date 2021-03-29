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
    // Code that's used in both code paths
    String path = (await getApplicationDocumentsDirectory()).path;
    File activeFile;
    String fileName = event.fileName, fullPath = path + "/$fileName";
    activeFile = File(fullPath);

    if (!activeFile.existsSync()) {
      if (event.createFileIfNeeded) {
        activeFile.createSync(recursive: true);
      } else {
        yield JsonState(
            isError: true,
            message:
                "File $fullPath does not exist and createFileIfNeeded is set to false.");
        return;
      }
    }

    assert(activeFile.existsSync());

    // Code paths
    switch (event.runtimeType) {
      case JsonRead:
        yield _read(activeFile);
        break;
      case JsonWrite:
        var e = event as JsonWrite;
        yield _write(activeFile, e.value != null ? e.value : "", e.append);
        break;
      case JsonClear:
        yield _write(activeFile, "", false);
        break;
    }
  }

  JsonWriteState _write(File activeFile, value, bool append) {
    if (value.toString().trim() == "" && !append) {
      activeFile.writeAsStringSync("");
      return JsonWriteState(
          isError: false, message: "Written contents to ${activeFile.path}");
    }
    var values = [];
    JsonReadState s = _read(activeFile);
    if (s.isError) return JsonWriteState(isError: true, message: s.message);
    var read = s.hasValue ? s.value : "";

    if (read != "" && append) {
      assert(read is List);
      for (var x in read) values.add(x);
    }
    values.add(value);
    activeFile.writeAsStringSync(jsonEncode(values));

    // debugPrint(activeFile.lastModifiedSync().toString());
    return JsonWriteState(
        isError: false, message: "Written contents to ${activeFile.path}");
  }

  JsonReadState _read(File activeFile) {
    var decoded;
    String buffer = activeFile.readAsStringSync();

    // Empty file
    if (buffer == '') {
      return JsonReadState(isError: false, value: []);
    } else {
      try {
        decoded = json.decode(buffer);
        return JsonReadState(isError: false, value: decoded);
      } catch (e) {
        String msgString = "Could not decode ${activeFile.path}";
        debugPrint("buffer is: $buffer");
        return JsonReadState(isError: true, message: msgString);
      }
    }
  }
}
