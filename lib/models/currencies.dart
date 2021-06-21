import 'package:flutter/widgets.dart';

enum Currency { EUR, GBP, USD, JPY, AUD, CAD, CNY, NZD, NONE }

String currencyCode(Currency currency) {
  return currency.toString().replaceAll("Currency.", "");
}

String currencySymbol(Currency currency) {
  switch (currency) {
    case Currency.EUR:
      return "€";

    case Currency.GBP:
      return "£";

    case Currency.USD:
      return "\$";

    case Currency.JPY:
      return "¥";

    case Currency.AUD:
      return "\$";

    case Currency.CAD:
      return "\$";

    case Currency.CNY:
      return "¥";

    case Currency.NZD:
      return "\$";

    case Currency.NONE:
      return "";
  }
}

String currencyName(BuildContext context, Currency currency) {
  switch (currency) {
    case Currency.NONE:
      return "";

    case Currency.EUR:
      return "Euro";

    case Currency.GBP:
      return "British Pound";

    case Currency.USD:
      return "U.S. Dollar";

    case Currency.JPY:
      return "Japanese YEN";

    case Currency.AUD:
      return "Australian Dollar";

    case Currency.CAD:
      return "Canadian Dollar";

    case Currency.CNY:
      return "Yuan";

    case Currency.NZD:
      return "New Zealand Dollar";
  }
}

String currencyFullName(BuildContext context, Currency currency) {
  switch (currency) {
    case Currency.NONE:
      return "";

    case Currency.EUR:
      return currencyCode(currency) + " - Euro";

    case Currency.GBP:
      return currencyCode(currency) + " - British Pound";

    case Currency.USD:
      return currencyCode(currency) + " - U.S. Dollar";

    case Currency.JPY:
      return currencyCode(currency) + " - Japanese YEN";

    case Currency.AUD:
      return currencyCode(currency) + " - Australian Dollar";

    case Currency.CAD:
      return currencyCode(currency) + " - Canadian Dollar";

    case Currency.CNY:
      return currencyCode(currency) + " - Yuan";

    case Currency.NZD:
      return currencyCode(currency) + " - New Zealand Dollar";
  }
}

List<Currency> currenciesWithoutNone() {
  List<Currency> currencies = List.from(Currency.values);
  currencies.removeWhere((element) => element == Currency.NONE);
  return currencies;
}

List<String> currencyCodes() {
  List<Currency> currencies = List.from(Currency.values);
  currencies.removeWhere((element) => element == Currency.NONE);
  return currencies.map((currency) => currencyCode(currency)).toList();
}

List<String> currencyNames(BuildContext context) {
  List<Currency> currencies = List.from(Currency.values);
  currencies.removeWhere((element) => element == Currency.NONE);
  return currencies.map((currency) => currencyName(context, currency)).toList();
}

List<String> currencyFullNames(BuildContext context) {
  List<Currency> currencies = List.from(Currency.values);
  currencies.removeWhere((element) => element == Currency.NONE);
  return currencies
      .map((currency) => currencyFullName(context, currency))
      .toList();
}

Currency currencyFromCode(String code) {
  return Currency.values
      .where(
        (element) => code.trim().toUpperCase() == currencyCode(element),
      )
      .first;
}
