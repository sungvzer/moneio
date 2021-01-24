import 'package:flutter/material.dart';

class Transaction {
  static const Map<String, String> symbols = {
    "EUR": "€",
    "USD": "\$",
    "JPY": "¥",
    "GBP": "£",
    "AUD": "\$",
    "CAD": "\$",
    "CHN": "¥",
    "NZD": "\$"
  };
  int id;
  String tag;
  String icon;
  double amount;
  String currency;
  DateTime date;

  Transaction(
      {this.id, this.tag, this.icon, this.amount, this.currency, this.date});

  Transaction.fromJSON(Map<String, dynamic> json) {
    this.id = json["id"] as int;
    this.tag = json["tag"] as String;
    this.icon = json["icon"] as String;
    this.amount = json["amount"] as double;
    this.currency = json["currency"] as String;

    try {
      this.date = DateTime.parse(json["date"]);
    } on FormatException catch (exception) {
      debugPrint(exception.message);
      this.date = DateTime(0);
    }
  }

  String getCurrencySymbol() => Transaction.symbols[this.currency];

  String getSeparatedAmountString({bool sign = false}) {
    /*TODO: Maybe there's a more efficient way to do this, 
    but I'm too tired of this function to think about it.*/
    int decimal = amount.toInt();
    String result = '';

    // To get the fractional part without losing precision we go through
    // the String form first.
    // 312.31 => "312.31" => [312, 31] => 31
    int fractional = int.parse(amount.toString().split('.')[1]);

    // Iterate through the digits of the decimal part in reverse
    // and add a point where it belongs
    List<String> reversedList = decimal.toString().split('').reversed.toList();
    for (int i = 0; i < reversedList.length; i++) {
      result += reversedList[i];
      if (i % 3 == 2 && i != reversedList.length - 1) result += '.';
    }

    // Reverse the result back and add the fractional part padded
    result = result.split('').reversed.join();
    result += ',' + fractional.toString().padRight(2, '0');

    // Add or remove a sign where needed
    if (!sign && amount < 0)
      result = result.replaceAll('-', '');
    else if (sign && amount > 0) result = '+' + result;

    return result;
  }
}
