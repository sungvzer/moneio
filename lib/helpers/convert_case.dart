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
