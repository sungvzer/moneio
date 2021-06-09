import 'dart:math';

import 'package:flutter/material.dart';
import 'package:moneio/constants.dart';

String getRandomString([int length = 32]) {
  assert(length > 0, "Length needs to be a positive integer");
  Random random;
  try {
    random = Random.secure();
  } catch (e) {
    int seed = DateTime.now().microsecondsSinceEpoch;
    random = Random(seed);
  }
  String characters =
      "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

  String randomString = "";
  while (--length >= 0) {
    int index = random.nextInt(62);
    randomString += characters[index];
  }

  return randomString;
}

TimeOfDay parseTimeString(String time) {
  // We consider time to never be null because of
  // the form validator that doesn't allow this.
  time = time.toUpperCase().trim();

  final RegExp twelveHourRegEx = RegExp(r"AM|PM");
  final List<String> splitTime =
      time.replaceAll(twelveHourRegEx, "").split(':');

  TimeOfDay parsedTime;
  bool isAM = false, isPM = false, isTwelveHour = false;
  int hour, minute;

  if (morePrinting) debugPrint("Got string: $time");

  isTwelveHour = time.contains(twelveHourRegEx);

  hour = int.parse(splitTime[0]);
  minute = int.parse(splitTime[1]);

  if (isTwelveHour) {
    isPM = time.contains(RegExp(r"PM"));
    isAM = !isPM;

    if (isAM && hour == 12) hour = 0;

    if (isPM && hour != 12) hour += 12;
  }
  parsedTime = TimeOfDay(hour: hour, minute: minute);
  return parsedTime;
}

String snakeToCamelCase(String str) {
  String result = "";

  bool shouldUpper = false;
  for (int index = 0; index < str.length; index++) {
    String char = str[index];
    if (shouldUpper) {
      shouldUpper = false;
      result += char.toUpperCase();
    } else if (char == '_') {
      shouldUpper = true;
    } else {
      result += char.toLowerCase();
    }
  }
  return result;
}

String camelToSnakeCase(String str) {
  String result = "";

  for (int index = 0; index < str.length; index++) {
    String char = str[index];
    if (char.toUpperCase() == char && index != 0) {
      result += '_${char.toLowerCase()}';
    } else {
      result += char.toLowerCase();
    }
  }
  return result;
}
