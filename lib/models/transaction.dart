import 'package:flutter/material.dart';

class Transaction extends Comparable {
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
    int decimal, fractional;
    String result = '';
    List<String> split, reversedList;

    // To get the decimal and fractional parts without losing precision
    // we go through the String form first.
    // 312.31 => "312.31" => [312, 31] => 31
    split = amount.abs().toString().split('.');
    decimal = int.parse(split[0]);
    fractional = int.parse(split[1]);

    // Iterate through the digits of the decimal part in reverse
    // and add a point where it belongs
    reversedList = decimal.toString().split('').reversed.toList();
    for (int i = 0; i < reversedList.length; i++) {
      result += reversedList[i];
      if (i % 3 == 2 && i != reversedList.length - 1) result += '.';
    }

    // Reverse the result back and add the fractional part padded
    result = result.split('').reversed.join();
    result += ',' + fractional.toString().padRight(2, '0');

    // Add sign back if needed
    if (sign) {
      result = (amount > 0 ? '+' : '-') + result;
    }

    return result;
  }

  @override
  int compareTo(other) {
    if (other.runtimeType != this.runtimeType)
      throw TypeError();
    else
      return this.date.compareTo(other.date);
  }
}
