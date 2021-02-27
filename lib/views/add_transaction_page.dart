import 'dart:ui';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:moneio/bloc/json/json_bloc.dart';
import 'package:moneio/color_palette.dart';
import 'package:moneio/constants.dart';

class AddTransactionPage extends StatefulWidget {
  AddTransactionPage({Key key}) : super(key: key);

  @override
  AddTransactionPageState createState() => AddTransactionPageState();
}

class AddTransactionPageState extends State<AddTransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTextStyle(
        style: TextStyle(
          fontFamily: "Poppins",
          color: ColorPalette.ImperialPrimer,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: _TransactionForm(),
            physics: BouncingScrollPhysics(),
            clipBehavior: Clip.none,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: ColorPalette.CasandoraYellow,
        elevation: 0,
        leading: Container(),
        centerTitle: true,
        title: Title(
          title: "mone.io",
          color: ColorPalette.ImperialPrimer,
          child: Text(
            "mone.io",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              color: ColorPalette.ImperialPrimer,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}

class _TransactionForm extends StatelessWidget {
  final GlobalKey<FormState> transactionFormKey =
      GlobalKey<FormState>(debugLabel: "TransactionForm");
  final Map<String, TextEditingController> _controllers = {
    "amount": TextEditingController(),
    "tag": TextEditingController(),
    "date": TextEditingController(),
    "time": TextEditingController(),
    "emoji": TextEditingController()
  };

  static const InputDecoration _decoration = InputDecoration(
    errorMaxLines: 3,
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorPalette.ImperialPrimer,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(14.0),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: ColorPalette.ImperialPrimer,
        width: 2,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(14.0),
      ),
    ),
    contentPadding: EdgeInsets.only(top: 1, bottom: 1, left: 20, right: 20),
  );

  @override
  Widget build(BuildContext context) {
    String _selectedCategory = "";
    String _selectedCurrency = "";
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Form(
        key: transactionFormKey,
        child: Column(
          children: <Widget>[
            LabelledFormField(
              "Tag",
              child: TextFormField(
                textInputAction: TextInputAction.next,
                decoration: _decoration,
                controller: _controllers["tag"],
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: ColorPalette.ImperialPrimer,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                autocorrect: true,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: LabelledFormField(
                    "Amount",
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: _decoration,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: ColorPalette.ImperialPrimer,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        CurrencyTextInputFormatter(),
                      ],
                      controller: _controllers["amount"],
                      validator: (value) {
                        if (value.isEmpty) return "Please enter an amount.";
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 1,
                  child: LabelledFormField(
                    "Currency",
                    child: DropdownButtonFormField(
                      validator: (str) =>
                          str == null ? "Please insert a currency" : null,
                      decoration: _decoration,
                      isExpanded: true,
                      onChanged: (value) {
                        _selectedCurrency = value.trim();
                      },
                      style: TextStyle(
                        fontFamily: "Poppins",
                        color: ColorPalette.ImperialPrimer,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                      items: CURRENCY_TO_SYMBOL.keys.map((final String key) {
                        const Map<String, String> map = CURRENCY_TO_SYMBOL;
                        String value = map[key];
                        return DropdownMenuItem(
                          child: Text("$value - $key"),
                          value: key,
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelledFormField(
                        "Date",
                        child: TextFormField(
                          decoration: _decoration,
                          validator: (value) {
                            return value == null || value == ""
                                ? "Please enter a date."
                                : null;
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: ColorPalette.ImperialPrimer,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          readOnly: true,
                          controller: _controllers["date"],
                          onTap: () => showDatePicker(
                            context: context,
                            firstDate: DateTime(1900, 1, 1),
                            lastDate: DateTime.now(),
                            initialDate: DateTime.now(),
                          ).then((value) {
                            final DateFormat f = DateFormat("dd/MM/yyyy");
                            var controller = _controllers["date"];
                            if (value == null) {
                              controller.text = "";
                              return;
                            }
                            controller.text = f.format(value);
                          }),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 20),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelledFormField(
                        "Time",
                        child: TextFormField(
                          decoration: _decoration,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: ColorPalette.ImperialPrimer,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          readOnly: true,
                          controller: _controllers["time"],
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((value) {
                              var controller = _controllers["time"];
                              if (value == null) {
                                controller.text = "";
                                return;
                              }
                              controller.text = value.format(context);
                            });
                          },
                          validator: (value) {
                            if (value == "") return "Please enter a time.";

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            LabelledFormField(
              "Category",
              child: DropdownButtonFormField(
                decoration: _decoration,
                isExpanded: true,
                onChanged: (value) {
                  _selectedCategory = value.toString().trim();
                },
                validator: (str) =>
                    str == null ? "Please enter a category" : null,
                style: TextStyle(
                  fontFamily: "Poppins",
                  color: ColorPalette.ImperialPrimer,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                items: CATEGORIES_TO_TEXT.values.map((final String value) {
                  const Map<String, String> map = CATEGORIES_TO_TEXT;
                  String key;
                  key = map.keys.where((y) => map[y] == value).first;
                  final String emoji = CATEGORIES_TO_EMOJI[key];
                  return DropdownMenuItem(
                    child: Text("$emoji - $value"),
                    value: key,
                  );
                }).toList(),
                hint: Center(child: Text("Please select a category")),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    child: Text(
                      "Add",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(100, 0)),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                            width: 2, color: ColorPalette.ImperialPrimer),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ColorPalette.CasandoraYellow),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          ColorPalette.ImperialPrimer),
                    ),
                    onPressed: () {
                      if (transactionFormKey.currentState.validate()) {
                        double amountNumber;

                        Map<String, dynamic> map = {};

                        String tag = _controllers["tag"].text.trim(),
                            date = _controllers["date"].text.trim(),
                            time = _controllers["time"].text.trim(),
                            amount = _controllers["amount"].text.trim(),
                            currency = _selectedCurrency;

                        TimeOfDay parsedTime = _parseTimeString(time);
                        bool isNegative = false;
                        List<int> dateList = [];

                        for (var entry in date.split('/')) {
                          dateList.add(int.parse(entry));
                        }

                        tag = tag.isNotEmpty ? tag : "Untitled";
                        if (amount.contains('-')) isNegative = true;
                        amount = amount.replaceAll(RegExp(r"\D"), "");
                        amountNumber = double.parse(amount) / 100;

                        if (isNegative) amountNumber *= -1;
                        // Initialize map
                        map["amount"] = amountNumber;
                        map["tag"] = tag;
                        map["category"] = _selectedCategory;
                        map["icon"] = CATEGORIES_TO_EMOJI[_selectedCategory];
                        map["date"] = DateTime(dateList[2], dateList[1],
                                dateList[0], parsedTime.hour, parsedTime.minute)
                            .toIso8601String();
                        map["currency"] = currency;

                        BlocProvider.of<JsonBloc>(context).add(JsonWrite(
                          "transactions.json",
                          value: map,
                        ));

                        debugPrint("Data:\n$map");
                        Navigator.maybePop(context)
                            .then((value) => value ? print("Ciao") : false);
                      }
                    },
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    child: Text(
                      "Back",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"),
                    ),
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(100, 0)),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(
                            width: 2, color: ColorPalette.ImperialPrimer),
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          ColorPalette.ImperialPrimer),
                    ),
                    onPressed: Navigator.of(context).pop,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  TimeOfDay _parseTimeString(String time) {
    // We consider time to never be null because of
    // the form validator that doesn't allow this.
    time = time.toUpperCase().trim();

    final RegExp twelveHourRegEx = RegExp(r"AM|PM");
    final List<String> splitTime =
        time.replaceAll(twelveHourRegEx, "").split(':');

    TimeOfDay parsedTime;
    bool isAM = false, isPM = false, isTwelveHour = false;
    int hour, minute;

    if (MORE_PRINTING) debugPrint("Got string: $time");

    isTwelveHour = time.contains(twelveHourRegEx);

    hour = int.parse(splitTime[0]);
    minute = int.parse(splitTime[1]);

    if (isTwelveHour) {
      isPM = time.contains(RegExp(r"PM"));
      isAM = !isPM;

      if (isAM && hour == 12) hour = 0;

      if (isPM && hour != 12) hour += 12;
    }
    parsedTime = TimeOfDay(hour: hour, minute: minute);
    if (MORE_PRINTING) debugPrint("Parsed it to: ${parsedTime.toString()}");
    return parsedTime;
  }
}

class LabelledFormField extends StatelessWidget {
  final String _label;
  final Widget child;
  final TextStyle style;
  const LabelledFormField(this._label, {this.child, this.style});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_label),
        SizedBox(
          height: 5,
        ),
        child,
      ],
    );
  }
}
