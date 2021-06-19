import 'package:flutter_test/flutter_test.dart';
import 'package:moneio/helpers/languages.dart';

main() {
  group('Languages test', () {
    test('Choice to string returns expected values', () {
      LanguageChoice choice = LanguageChoice.System;
      expect(languageChoiceToString(choice), "System");
      choice = LanguageChoice.Italian;
      expect(languageChoiceToString(choice), "Italian");
      choice = LanguageChoice.English;
      expect(languageChoiceToString(choice), "English");
    });
    test('Choice from string returns expected values', () {
      String system = "System";
      String english = "english";
      String italian = "itAlian";

      expect(languageChoiceFromString(system), LanguageChoice.System);
      expect(languageChoiceFromString(english), LanguageChoice.English);
      expect(languageChoiceFromString(italian), LanguageChoice.Italian);
    });
  });
}
