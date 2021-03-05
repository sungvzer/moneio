import 'package:moneio/models/transaction_category.dart';

const bool debug = false;
const bool morePrinting = false;


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
]
// This HACK enables us to cache initial values in TransactionCategory._cache if needed
.toList();

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
