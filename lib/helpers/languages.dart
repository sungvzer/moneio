enum LanguageChoice { System, English, Italian }

String languageChoiceToString(LanguageChoice choice) {
  return choice.toString().replaceAll("LanguageChoice.", "");
}

LanguageChoice languageChoiceFromString(String choice) {
  return LanguageChoice.values.firstWhere(
    (element) =>
        element.toString().trim().toUpperCase().replaceAll(
              "LANGUAGECHOICE.",
              "",
            ) ==
        choice.toUpperCase(),
  );
}
