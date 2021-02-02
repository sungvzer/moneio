import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:moneio/bloc/json/json_bloc.dart';

main() async {
  String fileName = "test/blocs/data/test.json";

  /*We create and delete the file to make sure it
   is not present at the time of running 'JsonWrite'*/
  await File(fileName).create(recursive: true);
  await File(fileName).delete(recursive: true);

  Map<String, dynamic> validJson = {
    "id": 0,
    "name": "Carl",
    "surname": "Johnson",
  };
  test('Valid JsonWrite', () {
    JsonBloc x = JsonBloc();
    x.listen((state) {
      expect(state.isError, false);
      expect(state.message, "Written value: ${state.value}");
    });
    x.add(JsonWrite(
      fileName: fileName,
      value: validJson,
    ));

    x.close();
  });

  test('Valid JsonRead', () {
    JsonBloc x = JsonBloc();
    x.listen((state) {
      expect(state.isError, false);
      expect(state.hasValue, true);
      expect(state.value, validJson);
    });

    x.add(JsonRead(fileName: fileName));

    x.close();
  });
}
