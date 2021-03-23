import 'package:flutter/material.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/models/transaction_category.dart';

const bool debug = false;
const bool morePrinting = false;

// TODO: Favourite user color!
Color accentColor = ColorPalette.CasandoraYellow;

List<TransactionCategory> categories = [
  TransactionCategory("CLOTHING", "Clothing and Accessories", "👚"),
  TransactionCategory("FOOD", "Food", "🍕"),
  TransactionCategory("ANIMAL", "Animals", "🐶"),
  TransactionCategory("INSURANCE", "Insurance", "⛑"),
  TransactionCategory("BILLS", "Bills and subscriptions", "🧾"),
  TransactionCategory("HOME", "Home", "🏠"),
  TransactionCategory("BODY_CARE", "Body care", "🧼"),
  TransactionCategory("ELECTRONIC", "Electronics and Software", "🤖"),
  TransactionCategory("FAMILY", "Family", "👪"),
  TransactionCategory("FINANCING", "Financing and Loan", "📊"),
  TransactionCategory("ENTERTAINMENT", "Entertainment", "🎥"),
  TransactionCategory("INVESTMENT", "Investments", "📈"),
  TransactionCategory("EDUCATION", "Education", "📚"),
  TransactionCategory("WORK_SALARY", "Work and Salary", "⚒"),
  TransactionCategory("GIFT", "Gifts and donations", "🎁"),
  TransactionCategory("GENERIC", "Generic", "💰"),
  TransactionCategory("REFUND", "Refunds", "↩"),
  TransactionCategory("RESTAURANTS", "Restaurants and Coffee Shops", "🍽️"),
  TransactionCategory("HEALTH", "Health", "🩺"),
  TransactionCategory("SPORT", "Sports", "⚽"),
  TransactionCategory("HOBBY", "Hobbies", "🔨"),
  TransactionCategory("TAX", "Taxes and commissions", "📝"),
  TransactionCategory("TRANSPORT", "Means of transportation", "🚌"),
  TransactionCategory("SALE", "Sales", "💰"),
  TransactionCategory("TOPUP", "Top ups", "🔃"),
  TransactionCategory("ATM", "ATM", "🏧"),
  TransactionCategory("CRYPTO", "Cryptocurrency", "💸"),
  TransactionCategory("SHOPPING", "Shopping", "🛍️"),
  TransactionCategory("NONE", "", "")
].toList(); // This HACK enables us to cache initial values in TransactionCategory._cache if needed

const Map<String, String> currencyToSymbol = {
  "EUR": "€",
  "USD": "\$",
  "JPY": "¥",
  "GBP": "£",
  "AUD": "\$",
  "CAD": "\$",
  "CHN": "¥",
  "NZD": "\$"
};

const Map<String, dynamic> defaultSettings = {
  "dark_mode": false,
  "human_readable": true,
  "accent_color": "0xfffeca57",
};
