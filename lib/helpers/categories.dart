import 'package:flutter/material.dart';
import 'package:moneio/helpers/constants.dart';

List<DropdownMenuItem<String>> getCategoriesMenuItems() {
  final values = Constants.categories();
  var list = <DropdownMenuItem<String>>[];

  list.add(
    DropdownMenuItem(
      child: Text("None"),
      value: "NONE",
    ),
  );

  for (var value in values.where((c) => c.key != "NONE")) {
    list.add(DropdownMenuItem(
      child: Text("${value.emoji} - ${value.name}"),
      value: value.key,
    ));
  }
  return list;
}
