const bool debug = false;
const bool morePrinting = false;
const Map<String, String> categoriesToText = {
  "CLOTHING": "Clothing and Accessories",
  "FOOD": "Food",
  "ANIMAL": "Animals",
  "INSURANCE": "Insurance",
  "BILLS": "Bills and subscriptions",
  "HOME": "Home",
  "BODY_CARE": "Body care",
  "ELECTRONIC": "Electronics and Software",
  "FAMILY": "Family",
  "FINANCING": "Financing and Loan",
  "ENTERTAINMENT": "Entertainment",
  "INVESTMENT": "Investments",
  "EDUCATION": "Education",
  "WORK_SALARY": "Work and Salary",
  "GIFT": "Gifts and donations",
  "GENERIC": "Generic",
  "REFUND": "Refunds",
  "RESTAURANTS": "Restaurants and Coffee Shops",
  "HEALTH": "Health",
  "SPORT": "Sports",
  "HOBBY": "Hobbies",
  "TAX": "Taxes and commissions",
  "TRANSPORT": "Means of transportation",
  "SALE": "Sales",
  "TOPUP": "Top ups",
  "ATM": "ATM",
  "CRYPTO": "Cryptocurrency",
  "SHOPPING": "Shopping"
};

const Map<String, String> categoriesToEmoji = {
  "CLOTHING": "👚",
  "FOOD": "🍕",
  "ANIMAL": "🐶",
  "INSURANCE": "⛑",
  "BILLS": "🧾",
  "HOME": "🏠",
  "BODY_CARE": "🧼",
  "ELECTRONIC": "🤖",
  "FAMILY": "👪", // TODO: Find a better, inclusive emoji ?
  "FINANCING": "📊",
  "ENTERTAINMENT": "🎥",
  "INVESTMENT": "📈",
  "EDUCATION": "📚",
  "WORK_SALARY": "⚒",
  "GIFT": "🎁",
  "GENERIC": "💰",
  "REFUND": "↩",
  "RESTAURANTS": "🍽️",
  "HEALTH": "🩺",
  "SPORT": "⚽",
  "HOBBY": "🔨",
  "TAX": "📝",
  "TRANSPORT": "🚌",
  "SALE": "💰",
  "TOPUP": "🔃",
  "ATM": "🏧",
  "CRYPTO": "💸",
  "SHOPPING": "🛍️"
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
