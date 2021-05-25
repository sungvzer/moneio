import 'package:flutter/material.dart';
import 'package:moneio/constants.dart';

List<DropdownMenuItem<String>> getCategoriesMenuItems() {
  final values = categories.values.toList();
  var list = <DropdownMenuItem<String>>[];

  list.add(
    DropdownMenuItem(
      child: Text("None"),
      value: "NONE",
    ),
  );

  for (var value in values.where((c) => c.uniqueID != "NONE")) {
    list.add(DropdownMenuItem(
      child: Text("${value.emoji} - ${value.name}"),
      value: value.uniqueID,
    ));
  }
  return list;
}
