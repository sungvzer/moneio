import 'package:flutter/material.dart';
import 'package:moneio/generated/l10n.dart';
import 'package:moneio/models/transaction_category.dart';

const bool debug = false;
const bool morePrinting = false;

class Constants {
  static const bool debug = false;
  static const bool morePrinting = false;
  static Map<String, TransactionCategory> _categories = {};
  static bool _categoriesHaveBeenInitialized = false;

  Map<String, TransactionCategory> get categoriesMap => _categories;

  static void initializeCategoriesMap(
    BuildContext context,
  ) {
    if (_categoriesHaveBeenInitialized) return;
    Localization local = Localization.of(context);
    var translatedStringsMap = {
      "CLOTHING": local.transactionCategoryClothing,
      "FOOD": local.transactionCategoryFood,
      "ANIMAL": local.transactionCategoryAnimal,
      "INSURANCE": local.transactionCategoryInsurance,
      "BILLS": local.transactionCategoryBills,
      "HOME": local.transactionCategoryHome,
      "BODY_CARE": local.transactionCategoryBodyCare,
      "ELECTRONIC": local.transactionCategoryElectronic,
      "FAMILY": local.transactionCategoryFamily,
      "FINANCING": local.transactionCategoryFinancing,
      "ENTERTAINMENT": local.transactionCategoryEntertainment,
      "INVESTMENT": local.transactionCategoryInvestment,
      "EDUCATION": local.transactionCategoryEducation,
      "WORK_SALARY": local.transactionCategoryWorkSalary,
      "GIFT": local.transactionCategoryGift,
      "GENERIC": local.transactionCategoryGeneric,
      "REFUND": local.transactionCategoryRefund,
      "RESTAURANTS": local.transactionCategoryRestaurants,
      "HEALTH": local.transactionCategoryHealth,
      "SPORT": local.transactionCategorySport,
      "HOBBY": local.transactionCategoryHobby,
      "TAX": local.transactionCategoryTax,
      "TRANSPORT": local.transactionCategoryTransport,
      "SALE": local.transactionCategorySale,
      "TOPUP": local.transactionCategoryTopup,
      "ATM": local.transactionCategoryATM,
      "CRYPTO": local.transactionCategoryCrypto,
      "SHOPPING": local.transactionCategoryShopping,
      "NONE": local.transactionCategoryNone,
    };
    var categoriesStrings = [
      "CLOTHING",
      "FOOD",
      "ANIMAL",
      "INSURANCE",
      "BILLS",
      "HOME",
      "BODY_CARE",
      "ELECTRONIC",
      "FAMILY",
      "FINANCING",
      "ENTERTAINMENT",
      "INVESTMENT",
      "EDUCATION",
      "WORK_SALARY",
      "GIFT",
      "GENERIC",
      "REFUND",
      "RESTAURANTS",
      "HEALTH",
      "SPORT",
      "HOBBY",
      "TAX",
      "TRANSPORT",
      "SALE",
      "TOPUP",
      "ATM",
      "CRYPTO",
      "SHOPPING",
      "NONE",
    ];
    var emojis = [
      "👚",
      "🍕",
      "🐶",
      "⛑",
      "🧾",
      "🏠",
      "🧼",
      "🤖",
      "👪",
      "📊",
      "🎥",
      "📈",
      "📚",
      "⚒",
      "🎁",
      "💰",
      "↩",
      "🍽️",
      "🩺",
      "⚽",
      "🔨",
      "📝",
      "🚌",
      "💰",
      "🔃",
      "🏧",
      "💸",
      "🛍️",
      "🚫",
    ];
    Map<String, TransactionCategory> map = {};
    for (int i = 0; i < categoriesStrings.length; i++) {
      String category = categoriesStrings[i], emoji = emojis[i];
      map[category] =
          TransactionCategory(category, translatedStringsMap[category]!, emoji);
    }
    _categories = Map.from(map);
    _categoriesHaveBeenInitialized = true;
  }

  static void refreshCategories(BuildContext context) {
    Localization local = Localization.of(context);
    var translatedStringsMap = {
      "CLOTHING": local.transactionCategoryClothing,
      "FOOD": local.transactionCategoryFood,
      "ANIMAL": local.transactionCategoryAnimal,
      "INSURANCE": local.transactionCategoryInsurance,
      "BILLS": local.transactionCategoryBills,
      "HOME": local.transactionCategoryHome,
      "BODY_CARE": local.transactionCategoryBodyCare,
      "ELECTRONIC": local.transactionCategoryElectronic,
      "FAMILY": local.transactionCategoryFamily,
      "FINANCING": local.transactionCategoryFinancing,
      "ENTERTAINMENT": local.transactionCategoryEntertainment,
      "INVESTMENT": local.transactionCategoryInvestment,
      "EDUCATION": local.transactionCategoryEducation,
      "WORK_SALARY": local.transactionCategoryWorkSalary,
      "GIFT": local.transactionCategoryGift,
      "GENERIC": local.transactionCategoryGeneric,
      "REFUND": local.transactionCategoryRefund,
      "RESTAURANTS": local.transactionCategoryRestaurants,
      "HEALTH": local.transactionCategoryHealth,
      "SPORT": local.transactionCategorySport,
      "HOBBY": local.transactionCategoryHobby,
      "TAX": local.transactionCategoryTax,
      "TRANSPORT": local.transactionCategoryTransport,
      "SALE": local.transactionCategorySale,
      "TOPUP": local.transactionCategoryTopup,
      "ATM": local.transactionCategoryATM,
      "CRYPTO": local.transactionCategoryCrypto,
      "SHOPPING": local.transactionCategoryShopping,
      "NONE": local.transactionCategoryNone,
    };
    Map<String, TransactionCategory> newMap = {};
    for (var entry in _categories.entries) {
      TransactionCategory cat = entry.value;
      cat.name = translatedStringsMap[cat.key]!;
      newMap[entry.key] = cat;
    }
    _categories = Map.from(newMap);
  }

  static TransactionCategory getCategory(String key) {
    assert(_categoriesHaveBeenInitialized);
    TransactionCategory? category = _categories[key];
    assert(category != null);
    return category!;
  }

  static List<TransactionCategory> categories() {
    assert(_categoriesHaveBeenInitialized);
    return _categories.values.toList();
  }
}

const Map<String, dynamic> defaultSettings = {
  "dark_mode": false,
  "human_readable": true,
  "favorite_currency": "EUR",
};
