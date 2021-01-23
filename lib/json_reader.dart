import "dart:convert";
import 'package:flutter/material.dart';

import 'package:moneio/models/transaction.dart';

class JSONReader {
  static Future<List<Transaction>> readFromJSON(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("./data/transactions.json");
    var decodedJSON;
    try {
      decodedJSON = json.decode(data);
    } on FormatException catch (e) {
      return Future.error(
          "JSON Could not be read: ${e.message}", StackTrace.current);
    }
    List<Transaction> result = [];
    for (Map<String, dynamic> data in decodedJSON) {
      Transaction element = Transaction.fromJSON(data);
      result.add(element);
    }
    return result;
  }
}
