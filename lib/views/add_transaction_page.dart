import 'package:flutter/material.dart';

class AddTransactionPage extends StatelessWidget {
  static const String id = "/home/add_transaction";
  const AddTransactionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.remove),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
