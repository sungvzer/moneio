import 'package:flutter/material.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/models/transaction_category.dart';

class Transaction extends Comparable {
  TransactionCategory? category; // TODO: Null safety

  // TODO: Is ID really necessary??
  int id;
  String tag;
  int amount;
  String currency; // TODO: Null safety
  DateTime? date; // TODO: Null safety

  Transaction({
    this.id = -1,
    this.tag = "",
    this.category,
    this.amount = 0,
    this.currency = "",
    this.date,
  });

  factory Transaction.fromMap(Map<String, dynamic> json) {
    DateTime parsed;
    try {
      parsed = DateTime.parse(json["date"]);
    } on FormatException catch (e) {
      debugPrint("Failed to parse date: ${e.message}");
      parsed = DateTime(0);
    }
    return Transaction(
      id: json["id"] == null ? 0 : json["id"] as int,
      tag: json["tag"] as String,
      category:
          TransactionCategory.fromMap(json["category"] as Map<String, dynamic>),
      amount: json["amount"] as int,
      currency: json["currency"] as String,
      date: parsed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": this.id,
      "tag": this.tag,
      "category": this.category?.toMap(), // TODO: Null safety
      "amount": this.amount,
      "currency": this.currency,
      "date": date?.toIso8601String(), // TODO: Null safety
    };
  }

  String? getCurrencySymbol() => currencyToSymbol[this.currency];

  String getSeparatedAmountString({bool sign = false, bool currency = false}) {
    final int absoluteAmount = amount.abs();
    final int decimal = (absoluteAmount / 100).truncate();
    final int fractional = absoluteAmount - decimal.abs() * 100;
    String result = '';
    final List<String> reversedList =
        decimal.toString().split('').reversed.toList();

    // Iterate through the digits of the decimal part in reverse
    // and add a point where it belongs
    for (int i = 0; i < reversedList.length; i++) {
      result += reversedList[i];
      if (i % 3 == 2 && i != reversedList.length - 1) result += ',';
    }

    // Reverse the result back and add the fractional part padded
    result = result.split('').reversed.join();
    result += '.' + fractional.toString().padRight(2, '0');

    if (currency) {
      // TODO: Null safety
      String? currencySymbol = this.getCurrencySymbol();
      if (currencySymbol != null) result = currencySymbol + result;
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

    // TODO: Null safety
    int dateCompare = 0;
    DateTime? thisDate = this.date, otherDate = other.date;
    if (thisDate != null && otherDate != null)
      dateCompare = thisDate.compareTo(otherDate);
    bool equal = true;
    equal &= (this.tag == other.tag);
    equal &= (this.amount == other.amount);
    equal &= (this.category == other.category);
    equal &= (this.currency == other.currency);
    if (equal)
      return 0;
    else
      return dateCompare;
  }
}
