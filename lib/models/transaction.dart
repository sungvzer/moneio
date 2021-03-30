import 'package:flutter/material.dart';
import 'package:moneio/constants.dart';
import 'package:moneio/models/transaction_category.dart';

class Transaction extends Comparable {
  TransactionCategory category;
  static int sId = 0;

  // TODO: Is ID really necessary??
  late int id;
  String tag;

  int amount; // TODO: Should we switch to BigInt instead?
  String currency;
  DateTime date;

  Transaction({
    int? id,
    this.tag = "",
    required this.category,
    this.amount = 0,
    this.currency = "",
    required this.date,
  }) {
    if (id != null) {
      if (morePrinting) debugPrint("Transaction: Getting existing id $id");
      this.id = id;
    } else {
      if (morePrinting) debugPrint("Transaction: Getting new id $sId");
      this.id = sId++;
    }
  }

  factory Transaction.fromMap(Map<String, dynamic> json) {
    DateTime parsed;
    try {
      parsed = DateTime.parse(json["date"]);
    } on FormatException catch (e) {
      debugPrint("Failed to parse date: ${e.message}");
      parsed = DateTime(0);
    }
    return Transaction(
      id: json["id"] as int?,
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
      "category": this.category.toMap(),
      "amount": this.amount,
      "currency": this.currency,
      "date": date.toIso8601String(),
    };
  }

  String getCurrencySymbol() => currencyToSymbol[this.currency] == null
      ? ""
      : currencyToSymbol[this.currency]!;

  String getSeparatedAmountString({
    bool sign = false,
    bool currency = false,
    bool humanReadable = false,
  }) {
    String result = '';
    final int absoluteAmount = amount.abs();

    const int thousandsLowerBound = 1000000,
        thousandsUpperBound = 99999999,
        thousandsDivider = 100000;

    const int millionsLowerBound = 100000000,
        millionsDivider = millionsLowerBound;

    if (humanReadable && amount.abs() >= thousandsLowerBound) {
      final bool isThousands = absoluteAmount >= thousandsLowerBound &&
          absoluteAmount <= thousandsUpperBound;

      final bool isMillionsOrMore = absoluteAmount >= millionsLowerBound;

      if (isThousands) {
        result = (absoluteAmount / thousandsDivider).floor().toString() + 'K';
      } else if (isMillionsOrMore) {
        result = (absoluteAmount / millionsDivider).floor().toString() + 'M';
      }
      // debugPrint("Amount: $amount -> $result");
    } else {
      final int decimal = (absoluteAmount / 100).truncate();
      final int fractional = absoluteAmount - decimal.abs() * 100;
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
    }
    if (currency) {
      String currencySymbol = this.getCurrencySymbol();
      result = currencySymbol + result;
    }

    // Add sign back if needed
    if (sign) {
      result = (amount > 0 ? '+' : '-') + result;
    }

    return result;
  }

  @override
  int get hashCode => super.hashCode;

  @override
  int compareTo(other) {
    if (other is! Transaction) throw TypeError();

    int dateCompare = 0;
    DateTime thisDate = this.date, otherDate = other.date;
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

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  bool operator ==(Object other) {
    if (other is! Transaction) throw TypeError();
    return this.amount == other.amount &&
        this.category == other.category &&
        this.currency == other.currency &&
        this.amount == other.amount &&
        this.tag == other.tag &&
        this.date == other.date;
  }
}
