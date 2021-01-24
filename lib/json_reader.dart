import "dart:convert";
import 'package:flutter/services.dart';
import 'package:moneio/constants.dart';

import 'package:moneio/models/transaction.dart';

class JSONReader {
  static Future<List<Transaction>> readTransactionsFromJSON() async {
    if (DEBUG) {
      // Used to test loading times in FutureBuilder
      Duration debugArtificialDelay = Duration(seconds: 4);
      await Future.delayed(debugArtificialDelay, () => print("Delay done"));
    }
    String data = await rootBundle.loadString("./data/transactions.json");
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
