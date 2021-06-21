import 'package:flutter/material.dart';
import 'package:moneio/helpers/constants.dart';

List<DropdownMenuItem<String>> getCategoriesMenuItems() {
  final values = Constants.categories();
  var list = <DropdownMenuItem<String>>[];

  for (var value in values) {
    list.add(DropdownMenuItem(
      child: Text("${value.emoji} - ${value.name}"),
      value: value.key,
    ));
  }
  return list;
}
