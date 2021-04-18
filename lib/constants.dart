import 'package:moneio/models/transaction_category.dart';

const bool debug = false;
const bool morePrinting = false;

Map<String, TransactionCategory> categories = {
  "CLOTHING": TransactionCategory(
    "CLOTHING",
    "Clothing and Accessories",
    "👚",
  ),
  "FOOD": TransactionCategory(
    "FOOD",
    "Food",
    "🍕",
  ),
  "ANIMAL": TransactionCategory(
    "ANIMAL",
    "Animals",
    "🐶",
  ),
  "INSURANCE": TransactionCategory(
    "INSURANCE",
    "Insurance",
    "⛑",
  ),
  "BILLS": TransactionCategory(
    "BILLS",
    "Bills and subscriptions",
    "🧾",
  ),
  "HOME": TransactionCategory(
    "HOME",
    "Home",
    "🏠",
  ),
  "BODY_CARE": TransactionCategory(
    "BODY_CARE",
    "Body care",
    "🧼",
  ),
  "ELECTRONIC": TransactionCategory(
    "ELECTRONIC",
    "Electronics and Software",
    "🤖",
  ),
  "FAMILY": TransactionCategory(
    "FAMILY",
    "Family",
    "👪",
  ),
  "FINANCING": TransactionCategory(
    "FINANCING",
    "Financing and Loan",
    "📊",
  ),
  "ENTERTAINMENT": TransactionCategory(
    "ENTERTAINMENT",
    "Entertainment",
    "🎥",
  ),
  "INVESTMENT": TransactionCategory(
    "INVESTMENT",
    "Investments",
    "📈",
  ),
  "EDUCATION": TransactionCategory(
    "EDUCATION",
    "Education",
    "📚",
  ),
  "WORK_SALARY": TransactionCategory(
    "WORK_SALARY",
    "Work and Salary",
    "⚒",
  ),
  "GIFT": TransactionCategory(
    "GIFT",
    "Gifts and donations",
    "🎁",
  ),
  "GENERIC": TransactionCategory(
    "GENERIC",
    "Generic",
    "💰",
  ),
  "REFUND": TransactionCategory(
    "REFUND",
    "Refunds",
    "↩",
  ),
  "RESTAURANTS": TransactionCategory(
    "RESTAURANTS",
    "Restaurants and Coffee Shops",
    "🍽️",
  ),
  "HEALTH": TransactionCategory(
    "HEALTH",
    "Health",
    "🩺",
  ),
  "SPORT": TransactionCategory(
    "SPORT",
    "Sports",
    "⚽",
  ),
  "HOBBY": TransactionCategory(
    "HOBBY",
    "Hobbies",
    "🔨",
  ),
  "TAX": TransactionCategory(
    "TAX",
    "Taxes and commissions",
    "📝",
  ),
  "TRANSPORT": TransactionCategory(
    "TRANSPORT",
    "Means of transportation",
    "🚌",
  ),
  "SALE": TransactionCategory(
    "SALE",
    "Sales",
    "💰",
  ),
  "TOPUP": TransactionCategory(
    "TOPUP",
    "Top ups",
    "🔃",
  ),
  "ATM": TransactionCategory(
    "ATM",
    "ATM",
    "🏧",
  ),
  "CRYPTO": TransactionCategory(
    "CRYPTO",
    "Cryptocurrency",
    "💸",
  ),
  "SHOPPING": TransactionCategory(
    "SHOPPING",
    "Shopping",
    "🛍️",
  ),
  "NONE": TransactionCategory(
    "NONE",
    "",
    "",
  )
};

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
  "favorite_currency": "EUR",
};
