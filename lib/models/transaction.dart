import 'package:flutter/material.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/models/transaction_category.dart';

class Transaction extends Comparable {
  TransactionCategory category;

  // TODO: Is ID really necessary??
  int id;
  String tag;
  double amount;
  String currency;
  DateTime date;

  Transaction({
    this.id,
    this.tag,
    this.category,
    this.amount,
    this.currency,
    this.date,
  });

  factory Transaction.fromJSON(Map<String, dynamic> json) {
    DateTime parsed;
    try {
      parsed = DateTime.parse(json["date"]);
    } on FormatException catch (e) {
      debugPrint("Failed to parse date: ${e.message}");
      parsed = DateTime(0);
    }
    return Transaction(
      id: json["id"] as int,
      tag: json["tag"] as String,
      category: TransactionCategory.fromMap(json["category"] as Map),
      amount: json["amount"] as double,
      currency: json["currency"] as String,
      date: parsed,
    );
  }

  String getCurrencySymbol() => currencyToSymbol[this.currency];

  String getSeparatedAmountString({bool sign = false, bool currency = false}) {
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
      if (i % 3 == 2 && i != reversedList.length - 1) result += ',';
    }

    // Reverse the result back and add the fractional part padded
    result = result.split('').reversed.join();
    result += '.' + fractional.toString().padRight(2, '0');

    if (currency && this.currency != null) {
      result = this.getCurrencySymbol() + result;
    }

    // Add sign back if needed
    if (sign) {
      result = (amount > 0 ? '+' : '-') + result;
    }

    return result;
  }

  @override
  int compareTo(other) {
    if (other is! Transaction) throw TypeError();
    final int dateCompare = this.date.compareTo(other.date);
    bool equal = true;
    equal &= (this.tag == other.tag);
    equal &= (this.amount == other.amount);
    equal &= (this.category == other.category);
    equal &= (this.currency == other.currency);
    equal &= dateCompare == 0;
    if (equal)
      return 0;
    else
      return dateCompare;
  }
}
